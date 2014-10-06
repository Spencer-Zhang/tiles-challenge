# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.tile').click ->
    self = this
    $.ajax '/tiles/update', 
      type: 'PUT',
      data: {name: $(self).text()},
      success: (data) ->
        $(self).css('background-color', 'white')
        $(self).text(".")
      error: () ->
        console.log('an error occurred')