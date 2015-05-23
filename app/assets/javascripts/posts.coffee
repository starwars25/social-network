# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

form_input = (data) ->
  output = "<div class=\"post\"><p><strong>#{data.post.from}</strong></p><p>#{data.post.content}</p><img src=\"#{data.post.image}\" class=\"img-responsive img-thumbnail\" /><hr></div>"


#  return ouput = "<div class=\"post\"><p><strong>" + data.post.from + "</strong></p><p>" + data.post.content + "</p><hr></div>";
