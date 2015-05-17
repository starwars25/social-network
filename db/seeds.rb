# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(username: 'admin', email: 'a.starwars.d@gmail.com', password: 'admin', password_confirmation: 'admin', activated: true, activated_at: Time.zone.now)

10.times do |i|
  User.create!(username: "development-user-#{i}", email: "development-user-email-#{i}@gmail.com", password: 'password', password_confirmation: 'password', activated: true, activated_at: Time.zone.now)
end

# counter = 0
# User.all.each do |user|
#   break if counter == 5
#   next if user.username == 'admin'
#   User.find_by(username: 'admin').make_friends user
#   counter += 1
# end

(3..5).each do |i|
  FriendRequest.create!(from_id: i, to_id: 1)
end

10.times do
  Post.create!(from_id: 1, to_id: 2, content: Faker::Lorem.sentence(5))
end

