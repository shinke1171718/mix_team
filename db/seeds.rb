# 部署をいくつか作成
departments = Department.create([
  { name: '不用品回収の窓口', position: 1 },
  { name: 'おそうじ合衆国', position: 2 },
  { name: 'GAIHEKI+', position: 3 },
  { name: 'SENBATSU', position: 4 },
  { name: 'GEKITAI', position: 5 },
  { name: '総務部', position: 6 },
  { name: '開発部', position: 7 },
  { name: 'その他', position: 99 }
])

# テストユーザーを10人作成
20.times do |i|
  User.create!(
    name: "Test User #{i + 1}",
    email: "k.niinomi@madoguchi.inc",
    position: User.positions.keys.sample,
    department_id: departments.sample.id,
    state: User.states.keys.sample
  )
end

puts "20 test users with the same email have been created."