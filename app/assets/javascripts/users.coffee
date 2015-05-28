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

