# Demo user
User.create!(name: 'John Doe',
            email: 'johndoe@example.com',
            age: 25,
            country_code: 'ZW',
            password: 'qweqwe',
            password_confirmation: 'qweqwe')

# Users
10.times do |i|
  name = Faker::Name.name
  email = Faker::Internet.safe_email("user-#{i}")
  password = Faker::Internet.password(6)
  age = rand(12..90)
  country_code = Faker::Address.country_code
  avatar = Faker::Avatar.image("#{i}", '250x250')
  User.create!(name: name,
              email: email,
              age: age,
              country_code: country_code,
              avatar: avatar,
              password: password,
              password_confirmation: password)
end

# Friendships
User.all.each do |user|
  User.all.sample(5).each do |friend|
    unless user.friends.include?(friend) || friend == user
      user.friends << friend
      friend.friends << user
    end
  end
end

# Posts
3.times do
  User.all.each do |user|
    title = Faker::Lorem.sentence(2, false, 2)
    body = Faker::Lorem.paragraph(5)
    user.posts.create!(title: title, body: body)
  end
end

# Comments
User.all.each do |user|
  Post.all.sample(5).each do |post|
    body = Faker::Lorem.sentence
    post.comments.create(user: user, body: body)
  end
end

# Likes
User.all.each do |user|
  Post.all.sample(5).each do |post|
    post.likes.create(user: user)
  end
end
