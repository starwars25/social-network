# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(username: 'admin', email: 'a.starwars.d@gmail.com', password: 'admin', password_confirmation: 'admin', activated: true, activated_at: Time.zone.now)

# 10.times do |i|
#   User.create!(username: "development-user-#{i}", email: "development-user-email-#{i}@gmail.com", password: 'password', password_confirmation: 'password', activated: true, activated_at: Time.zone.now)
# end
#
# # counter = 0
# # User.all.each do |user|
# #   break if counter == 5
# #   next if user.username == 'admin'
# #   User.find_by(username: 'admin').make_friends user
# #   counter += 1
# # end
#
# (3..5).each do |i|
#   FriendRequest.create!(from_id: i, to_id: 1)
# end
#
# 10.times do
#   Post.create!(from_id: 1, to_id: 2, content: Faker::Lorem.sentence(5))
# end
#
# dialog = Dialog.create(name: 'Test')
# dialog.add_members([User.all[0], User.all[1]])
# 10.times do
#   Message.create(dialog_id: dialog.id, user_id: User.all[0].id, content: Faker::Lorem.sentence(5))
# end

20.times { |i| User.create!(username: Faker::Name.name, email: "dev-user-#{i + 1}@gmail.com", password: 'password', password_confirmation: 'password', activated: true, activated_at: Time.zone.now) }

user = User.find_by(email: 'a.starwars.d@gmail.com')
(2..6).each do |i|
  friend = User.find_by(id: i)
  user.make_friends(friend)
  dialog = Dialog.create
  dialog.add_members([user, friend])
  dialog.update_attribute(:name, "#{user.username} #{friend.username}")
  5.times do
    dialog.messages.create(user_id: user.id, content: Faker::Lorem.sentence(5))
    dialog.messages.create(user_id: friend.id, content: Faker::Lorem.sentence(5))
  end
end

(5..11).each { |i| FriendRequest.create(from_id: i, to_id: user.id) }

users = []
(1..6).each { |i| users << User.find_by(id: i) }

dialog = Dialog.create
dialog.update_attribute(:name, 'Test')
dialog.add_members(users)
5.times { users.each { |user| dialog.messages.create(user_id: user.id, content: Faker::Lorem.sentence(5)) } }

user = User.first
10.times { Post.create(from_id: user.id, to_id: user.id, content: Faker::Lorem.sentence(5)) }
users.each { |friend| Post.create(from_id: friend.id, to_id: user.id, content: Faker::Lorem.sentence(5)) }

users = []
(2..21).each { |i| users << User.find_by(id: i) }

users.each { |u| Post.create(from_id: u.id, to_id: u.id, content: Faker::Lorem.sentence(5)) }

users = User.find_by(id: 1).friends
users.each { |u| Post.create(from_id: u.id, to_id: u.id, content: 'This must be in feed.') }