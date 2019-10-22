User.create!(name:  "MinhLun",
  email: "example@railstutorial.org",
  password: "111111",
  password_confirmation: "111111",
  admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "111111"
  User.create!(name: name,
    email: email,
    password: password,
    password_confirmation: password)
end
