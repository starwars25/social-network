require_relative 'auth'
require_relative 'vkapi'
include API
include Authentication

# Authentication::Auth.authenticate('alexb251997@mail.ru', '5008851alex')

auth = Auth.new
token = auth.authenticate 'alexb251997@mail.ru', '5008851alex'
friends = Friend.get_friends token
puts friends
