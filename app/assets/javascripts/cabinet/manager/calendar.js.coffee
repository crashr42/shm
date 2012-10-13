# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$('.event-info').click ->
  $.post '/cabinet/manager/event/show', id:$(@).attr 'data-id' , (data) ->
    modal = $('.modal')
    modal.find('.modal-body').first().html(data)
    modal.modal('show')
  return false