n = 1

title = Faker::Pokemon.name

while n <= 100
  Blog.create(
    title: title,
    user_id: n
  )
  n = n + 1
end
