20.times do |n|
  name = Faker::Pokemon.name
  email = Faker::Internet.email
  password = Faker::Internet.password
  # uid = SecureRandom.uuid

  User.create(
    name: name,
    email: email,
    password: password,
    uid: n
  )
end
