Article.destroy_all
User.destroy_all

3.times do
  User.create!(
    username:Faker::Name.first_name,
    email:Faker::Name.first_name + "@yopmail.com",
    password:'azerty'
  )
end

10.times do
  Article.create!(
    title:Faker::Restaurant.name,
    content:Faker::Restaurant.description,
    user_id: User.all.sample.id
  )
end
