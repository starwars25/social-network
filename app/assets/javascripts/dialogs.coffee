# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


@formInput = (data) ->
  "<tr><td>#{data.message.from}</td><td>#{data.message.content}</td></tr>"

#alert 'Hello, world'
@check_dialog_enter = (e) ->
  if e.which == 13
    $('#new_message').submit()