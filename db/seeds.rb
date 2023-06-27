# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

#

labels = [
  { label_name: 'label1'},
  { label_name: 'label2'},
  { label_name: 'label3'},
  { label_name: 'label4'},
  { label_name: 'label5'},
  { label_name: 'label6'},
  { label_name: 'label7'},
  { label_name: 'label8'},
  { label_name: 'label9'},
  { label_name: 'label10'},
]

labels.each do |label|
  Label.create!(label)
end

10.times do |i|
  Task.create!(title: "タイトル", content: "はれ", end_time: "2023-06-01", priority: "低", status: "完了", user_id: User.first)
end

10.times do |i|
  Task.create!(title: "タイトル", content: "あめ", end_time: "2023-06-01", priority: "高", status: "未着手", user_id: User.second)
end

User.create!(
  name: "管理者",
  email: "2121@dic.com",
  password: "212121",
  password_confirmation: "212121",
  admin: true
)

User.create!(
  name: "seed1",
  email: "1111@dic.com",
  password: "111111",
  password_confirmation: "111111"
)

User.create!(
  name: "seed2",
  email: "2222@dic.com",
  password: "222222",
  password_confirmation: "222222"
)

User.create!(
  name: "seed3",
  email: "3333@dic.com",
  password: "333333",
  password_confirmation: "333333"
)

User.create!(
  name: "seed4",
  email: "4444@dic.com",
  password: "444444",
  password_confirmation: "444444"
)

User.create!(
  name: "seed5",
  email: "5555@dic.com",
  password: "555555",
  password_confirmation: "555555"
)

User.create!(
  name: "seed6",
  email: "6666@dic.com",
  password: "666666",
  password_confirmation: "666666"
)

User.create!(
  name: "seed7",
  email: "7777@dic.com",
  password: "777777",
  password_confirmation: "777777"
)

User.create!(
  name: "seed8",
  email: "8888@dic.com",
  password: "888888",
  password_confirmation: "888888"
)

User.create!(
  name: "seed9",
  email: "9999@dic.com",
  password: "999999",
  password_confirmation: "999999"
)

User.create!(
  name: "seed12",
  email: "1212@dic.com",
  password: "121212",
  password_confirmation: "121212"
)
