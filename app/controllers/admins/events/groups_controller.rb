class Admins::Events::GroupsController < Admins::BaseController
  require 'net/http'
  require 'uri'
  require 'json' 

  before_action :set_event_and_member

  def create
    min_members_required = 10
    max_attempts = 10000
    attempt = 0

    if @event.members.count < min_members_required
      redirect_to admins_event_path(@event), alert: "グループ分けには#{min_members_required}人以上の参加が必要です。" and return
    end

    group_sizes = build_group_sizes(@event)

    loop do
      attempt += 1
      
      mix_members = evenly_managers(@members, group_sizes)
      grouped_members = group_members(mix_members, group_sizes)
      
      if member_overlap?(grouped_members) || attempt >= max_attempts
        create_groups(@event, grouped_members)
        redirect_to admins_event_path(@event), notice: 'グループが正常に作成されました。'
        break
      end
    end
  
    @event.update(state: :closed)
    send_message_to_google_chat(@event)
  end

  private

  def set_event_and_member
    @event = Event.find params[:event_id]
    @members = @event.members.includes(:user)
  end

  def build_group_sizes(event)
    total_members = event.members.count
    max_group_size = event.max_group_size
    min_group_size = event.min_group_size
  
    group_sizes = []
    loop_count = -1

    while loop_count < 1000
      loop_count += 1
      remaining_members = total_members
      group_sizes = []

      # ループ毎に total_members を減少させる
      remaining_members = total_members - (max_group_size * loop_count) if loop_count > 0

      max_groups_count = loop_count > 0 ? (max_group_size * loop_count) / max_group_size : remaining_members / max_group_size
      
      max_groups_count.times { group_sizes << max_group_size }
      remaining_members = total_members - (max_group_size * max_groups_count)

      if remaining_members % min_group_size == 0
        # 割り切れる場合は最小グループを追加して終了
        min_groups_count = remaining_members / min_group_size
        min_groups_count.times { group_sizes << min_group_size }
        break
      end

    end
  
    group_sizes
  end

  def evenly_managers(members, group_sizes)
    # マネージャーと通常のメンバーを分ける
    manager_members = members.select { |member| member.user.position == 'manager' }
    normal_members = members.reject { |member| member.user.position == 'manager' }
    
    # 最大必要なマネージャーの数を group_sizes に基づいて決定
    required_managers = group_sizes.size
    
    # マネージャーをランダムに並び替え
    manager_members.shuffle!
    
    # 余ったマネージャーを通常メンバーに含める
    extra_managers = manager_members.drop(required_managers)
    
    # 必要な数だけマネージャーを抽出
    selected_managers = manager_members.take(required_managers)
    
    # 通常メンバーをランダムに並び替え、余ったマネージャーを含める
    normal_members.concat(extra_managers).shuffle!
    
    # 各グループにマネージャーを均等に分けて混ぜる
    mixed_members = []
    normal_members.each_slice(3).with_index do |slice, index|
      mixed_members.concat(slice)
      mixed_members << selected_managers[index] if index < selected_managers.size
    end
  
    mixed_members
  end  

  def group_members(members, group_sizes)
    grouped_members = {}
    current_index = 0
  
    # 各グループサイズに従ってメンバーを分割
    group_sizes.each_with_index do |group_size, index|
      group = members[current_index, group_size]
      grouped_members[index + 1] = group
      current_index += group_size
    end
  
    grouped_members
  end

  def create_groups(event, grouped_members)
    # アルファベットのリスト
    group_names = ('A'..'Z').to_a
    
    grouped_members.each_with_index do |(group_index, members), index|
      group_name = group_names[index]
      
      # sort_order をインデックス + 1 に設定
      group = Group.create!(
        event_id: event.id,
        group_name: "#{group_name}チーム",
        sort_order: index + 1
      )
      
      members.each do |member|
        member.update!(group_id: group.id)
      end
    end
  end

  def member_overlap?(grouped_members)
    latest_group = Group.order(created_at: :desc).first
    return true unless latest_group
  
    # 最新のグループに紐づくイベントを取得
    event = latest_group.event
  
    # イベントに紐づくグループを取得し、そのグループのメンバーを含める
    current_groups = event.groups.includes(:members)
  
    # grouped_members にある各グループごとに処理
    grouped_members.each do |group_index, members|
      next if members.nil? || members.empty?
      
      # 部署ごとのメンバー数をカウント
      department_counts = Hash.new(0)
      members.each do |member|
        department_id = member.user.department_id
        department_counts[department_id] += 1
  
        # 同じ部署のメンバーが3人以上いる場合はfalseを返す
        return false if department_counts[department_id] > 2
      end
  
      # 新しいメンバーのユーザーIDを取得
      new_member_ids = members.map(&:user_id)
  
      # 現在のグループと比較して同じメンバーがいるかを確認
      current_groups.each do |current_group|
        current_member_ids = current_group.members.pluck(:user_id)
  
        # 重複するメンバーIDを確認
        common_members = new_member_ids & current_member_ids
  
        # 1名以上同じメンバーがいれば false を返す
        return false if common_members.size >= 2
      end
    end
  
    true
  end

  def send_message_to_google_chat(event)
    webhook_url = ENV['GOOGLE_CHAT_WEBHOOK_URL']
  
    # グループとメンバー情報を整形
    group_details = event.groups.includes(:members).group_by(&:group_name).map do |group_name, groups|
      member_details = groups.map do |group|
        group.members.map { |member| "#{member.user.name}" }
      end.flatten
  
      "#{group_name}:\n" + member_details.join("\n")
    end.join("\n\n")
  
    # イベントの日付を指定のフォーマットで取得
    formatted_event_date = event.event_date.strftime('%Y年%m月%d日')
  
    # 送信するメッセージ
    message = {
      text: "[自動送信]\n" \
            "グループ分けが完了しました。\n\n" \
            "イベント詳細\n" \
            "=========================\n" \
            "開催日: \n" \
            "#{formatted_event_date}\n\n" \
            "イベント名: \n" \
            "#{event.title}\n\n" \
            "メモ: \n" \
            "#{event.memo}\n" \
            "=========================\n\n" \
            "[グループ分けの結果]\n\n#{group_details}"
    }
  
    # HTTPリクエストを送信
    uri = URI.parse(webhook_url)
    header = {'Content-Type': 'application/json'}
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = message.to_json
  
    response = http.request(request)
    
    # レスポンスを確認
    if response.code == '200'
      puts 'メッセージがGoogle Chatに送信されました。'
    else
      puts "エラーが発生しました: #{response.body}"
    end
  end
end
