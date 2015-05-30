# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/



max = () ->
  output = 0
  $('.user-tile').each () ->
    h = $(this).height()
    if h > output
      output = h
  return output

@equalize = () ->
  maximum = max()
  $('.user-tile').each () ->
    $(this).height(maximum)

@check_size = () ->
  size_in_megabytes = this.files[0].size / 1024 / 1024
  if size_in_megabytes > 5
    alert 'Maximum file size is 5MB. Please choose a smaller file.'

@hint_username = () ->
  value_of_input = $(this).val().length
  if value_of_input < 4
    $('#info').html('<div class= "alert alert-danger">Too short username</div>')
  else if value_of_input > 40
    $('#info').html('<div class= "alert alert-danger">Too long username</div>')
  else
    $('#info').html('')


@password_hint = () ->
  value_of_input = $(this).val().length
  if value_of_input < 4
    $('#info').html('<div class= "alert alert-danger">Too short password</div>')
  else
    $('#info').html('')


@password_matching = () ->
  value_of_input = $(this).val()
  value_of_password = $('#user_password').val()
  if value_of_input != value_of_password
    $('#info').html('<div class= "alert alert-danger">Passwords do not match</div>')
  else
    $('#info').html('')




