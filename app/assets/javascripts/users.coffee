# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#var usrInput = document.getElementById("user_username");
#usrInput.onchange = function () {
#  if (usrInput.value.length < 4 || usrInput.value.length > 20) {
#  document.getElementById("hint").innerHTML = "ТЫ БЛЯТЬ ЮЗЕР КРИВОРУКИЙ СУКА";
#}
#else {
#document.getElementById("hint").innerHTML = "";
#}
#}
#load = () ->
#  user_input = document.getElementById('user_username')
#  user_input.onkeyup = () ->
#    if user_input.value.length < 4 or user_input.value.length > 20
#      document.getElementById("hint").innerHTML = "ТЫ БЛЯТЬ ЮЗЕР КРИВОРУКИЙ СУКА"
#    else
#      document.getElementById("hint").innerHTML = ""
#
#
#window.onload = load

#max = (array) ->
#  output = array[0]
#  for element in array
#    if element > ouput
#      output = element
#  return output
#
#
#users = $('.user-tile')
#users_witdhs = []
#for user in users
#  users.push user.height()
#
#
#
#
#maximum = max(users_witdhs)
#
#for user in users
#  user.height(maximum)

max = () ->
  output = 0
  $('.user-tile').each ->
    h = $(this).height()
    if h > output
      output = height
  return output

maximum = max()
$('.user-tile').each ->
  $(this).height(maximum)