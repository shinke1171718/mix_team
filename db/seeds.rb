# # 部署をいくつか作成
Department.create([
  { name: '不用品回収の窓口', position: 1 },
  { name: 'おそうじ合衆国', position: 2 },
  { name: 'ブランド査定の窓口', position: 3 },
  { name: 'GAIHEKI+', position: 4 },
  { name: 'SENBATSU', position: 5 },
  { name: 'GEKITAI', position: 6 },
  { name: '総務部', position: 7 },
  { name: '開発部', position: 8 },
  { name: 'その他', position: 99 }
])


# ＝＝＝＝＝テストデータを作成するseed＝＝＝＝＝
# rails db:rollback STEP=10
# rails db:migrate
# rails db:seed 

# Adminデータの作成
puts "Creating an admin..."
Admin.create!(
  email: "test@madoguchi.inc",
  password: "testpassword",
  password_confirmation: "testpassword"
)

# 社員データを登録（ステータス：有効）：
User.create!([
  { name: '堀込統吾', email: 'horigome@madoguchi.inc', position: 20, department_id: 5, state: 0 },
  { name: '安岡尚和', email: 'yasuoka@madoguchi.inc', position: 30, department_id: 9, state: 1 },
  { name: '安積伸顕', email: 'asaka@madoguchi.inc', position: 10, department_id: 8, state: 0 },
  { name: '恩田雅史', email: 'onda@madoguchi.inc', position: 10, department_id: 4, state: 0 },
  { name: '過能悠太', email: 'y.kano@madoguchi.inc', position: 10, department_id: 1, state: 0 },
  { name: '岩城弥来', email: 'm.iwaki@madoguchi.inc', position: 10, department_id: 4, state: 0 },
  { name: '近藤亜海', email: 'kondo@madoguchi.inc', position: 20, department_id: 7, state: 0 },
  { name: '高橋 知也', email: 't.takahashi@madoguchi.inc', position: 0, department_id: 2, state: 0 },
  { name: '高野 悟', email: 's.takano@madoguchi.inc', position: 10, department_id: 7, state: 0 },
  { name: '今井遥', email: 'h.imai@madoguchi.inc', position: 10, department_id: 4, state: 0 },
  { name: '佐々木雄太', email: 'sasaki@madoguchi.inc', position: 10, department_id: 7, state: 0 },
  { name: '佐藤ひかる', email: 'h.sato@madoguchi.inc', position: 20, department_id: 3, state: 0 },
  { name: '山田一輝', email: 'k.yamada@madoguchi.inc', position: 10, department_id: 2, state: 0 },
  { name: '山田竜希', email: 'r.yamada@madoguchi.inc', position: 10, department_id: 3, state: 0 },
  { name: '紙谷将央', email: 'kamiya@madoguchi.inc', position: 20, department_id: 8, state: 0 },
  { name: '小原巨人', email: 'obara@madoguchi.inc', position: 20, department_id: 1, state: 0 },
  { name: '小野悠祐', email: 'ono@madoguchi.inc', position: 20, department_id: 2, state: 0 },
  { name: '植杉達樹', email: 't.uesugi@madoguchi.inc', position: 10, department_id: 1, state: 0 },
  { name: '新家恭弥', email: 'k.niinomi@madoguchi.inc', position: 10, department_id: 8, state: 0 },
  { name: '清水駿佑', email: 'shimizu@madoguchi.inc', position: 20, department_id: 4, state: 0 },
  { name: '西山雄大', email: 'nishiyama@madoguchi.inc', position: 10, department_id: 2, state: 0 },
  { name: '西涼花', email: 's.nishi@madoguchi.inc', position: 10, department_id: 4, state: 0 },
  { name: '早津泰我', email: 't.hayatsu@madoguchi.inc', position: 0, department_id: 5, state: 0 },
  { name: '竹下謙真', email: 'k.takeshita@madoguchi.inc', position: 10, department_id: 1, state: 0 },
  { name: '鶴見由香莉', email: 'tsurumi@madoguchi.inc', position: 0, department_id: 9, state: 0 },
  { name: '田中亜美', email: 'a.tanaka@madoguchi.inc', position: 10, department_id: 8, state: 0 },
  { name: '渡邊りさ', email: 'r.watanabe@madoguchi.inc', position: 10, department_id: 1, state: 0 },
  { name: '梅田樹音', email: 'j.umeda@madoguchi.inc', position: 10, department_id: 2, state: 0 },
  { name: '富田凛', email: 'r.tomita@madoguchi.inc', position: 0, department_id: 1, state: 0 },
  { name: '富澤勇太', email: 'y.tomizawa@madoguchi.inc', position: 0, department_id: 3, state: 0 },
  { name: '浮田南', email: 'ukita@madoguchi.inc', position: 10, department_id: 7, state: 0 },
  { name: '福士雅也', email: 'fukushi@madoguchi.inc', position: 30, department_id: 9, state: 1 },
  { name: '有井宏之輔', email: 'h.ari@madoguchi.inc', position: 10, department_id: 1, state: 0 },
  { name: '留木涼花', email: 'tomeki@madoguchi.inc', position: 10, department_id: 7, state: 0 },
  { name: '林崎凌太', email: 'r.hayashizaki@madoguchi.inc', position: 0, department_id: 4, state: 0 },
  { name: '鈴木賢正', email: 'k.suzuki@madoguchi.inc', position: 10, department_id: 1, state: 0 },
  { name: '鈴木翔太', email: 's.suzuki@madoguchi.inc', position: 20, department_id: 6, state: 0 },
  { name: '高橋平明', email: 'takahashi@madoguchi.inc', position: 0, department_id: 4, state: 0 }
])


# 20個のイベントを作成
puts "Creating 20 events..."
20.times do |i|
  Event.create!(
    title: "Event #{i + 1}",
    memo: "This is event number #{i + 1}",
    max_group_size: 4,
    min_group_size: 3,
    state: 1,
    invitees_count: 38,
    event_date: Date.today + i.days
  )
end
puts "20 events have been created."

# ユーザーとイベントを紐づけてメンバーレコードを作成
puts "Creating members for events..."
Event.all.each do |event|
  users = User.enable
  users.each do |user|
    Member.create!(
      event_id: event.id,
      user_id: user.id
    )
  end
end
puts "Members have been assigned to events."