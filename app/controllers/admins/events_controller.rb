class Admins::EventsController < Admins::BaseController
  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.invitees_count = User.enabled.count
  
    if @event.save
      users = if params[:event][:include_executives] == "true"
                User.enabled
              else
                User.enabled.where.not(position: :executive)
              end
  
      users.find_each do |user|
        EventMailer.participation(user, @event).deliver_later
      end
  
      redirect_to admins_event_path(@event), notice: 'イベント作成に成功しました。'
    else
      flash[:alert] = "作成に失敗しました。"
      render :new, status: :unprocessable_entity
    end
  end
  

  def show
    @event = Event.includes(members: { user: :department }).find(params[:id])
    @join_users = @event.users.includes(:department).ordered_position
    @non_members = User.enabled.ordered_position.where.not(id: @event.members.select(:user_id))
    member_user_ids = @event.members.pluck(:user_id)
    @non_members = User.enabled.includes(:department).ordered_position.where.not(id: member_user_ids)
  end

  def destroy
    @event = Event.find params[:id]

    return redirect_to admins_root_path, alert: '削除するイベントが見つかりませんでした。' if @event.nil?

    if @event.destroy
      redirect_to admins_root_path, notice: 'イベント削除に成功しました。'
    else
      redirect_to admins_event_path(@event), alert: 'イベント削除に失敗しました。'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :memo, :max_group_size, :min_group_size, :state, :event_date)
  end
end
