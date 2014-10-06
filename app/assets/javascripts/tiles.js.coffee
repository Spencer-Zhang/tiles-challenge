# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  console.log("Javascript is loaded!")

  $('.tile').click ->
    $(this).css('background-color', 'white')
    $(this).text('')