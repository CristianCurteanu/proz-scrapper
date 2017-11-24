# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $('.message').on 'click', (e) ->
    $(e.target.parentElement).fadeOut 500, 'swing', false

  setTimeout ->
    $('.flash').fadeOut 500, 'swing', false
  , 3000