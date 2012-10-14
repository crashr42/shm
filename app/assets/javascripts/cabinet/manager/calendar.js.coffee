App.module('/cabinet/manager/calendar', ->
  $ = jQuery

  $('.event-info').click ->
    $.post '/cabinet/manager/event/show', id:$(@).attr 'data-id' , (data) ->
      modal = $('.modal')
      modal.find('.modal-body').first().html(data)
      modal.modal('show')
    return false
)