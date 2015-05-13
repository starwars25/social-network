# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create!(username: 'admin', email: 'a.starwars.d@gmail.com', password: 'admin', password_confirmation: 'admin')

10.times do |i|
  User.create!(username: "development-user-#{i}", email: "development-user-email-#{i}@gmail.com", password: 'password', password_confirmation: 'password')
end
