# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Check if enter is pressed
@check_key = (e) ->
  if e.which == 13
    $('#new_post').submit()

# Form html code
@form_input = (data) ->
  output = "<div class=\"row\"><div class=\"col-md-2\"><strong>#{data.post.from}</strong></div><div class=\"col-md-10\"><p>#{data.post.content}</p></div></div>"


