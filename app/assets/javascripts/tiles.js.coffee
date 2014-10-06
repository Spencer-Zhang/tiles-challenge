# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  clickCount = 0


  loadMostClicked = () ->
    $.ajax '/tiles/most_clicked',
      type: "GET",
      dataType: "text",
      success: (data) ->
        $('.container').html(data)


  incrementClickCount = () ->
    clickCount += 1
    loadMostClicked() if(clickCount == 64)


  $('.tile').click ->
    self = this
    $(self).off()
    incrementClickCount()

    $.ajax '/tiles/update', 
      type: 'PUT',
      data: {name: $(self).text()},
      success: (data) ->
        $(self).css('background-color', 'white')
        $(self).text("")
      error: () ->
        $(self).css('background-color', 'red')
