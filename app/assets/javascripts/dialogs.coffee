# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Instantly add to page
@formInput = (data) ->
  "<tr><td>#{data.message.from}</td><td>#{data.message.content}</td></tr>"

# Check if enter is pressed and submit form
@check_dialog_enter = (e) ->
  if e.which == 13
    $('#new_message').submit()