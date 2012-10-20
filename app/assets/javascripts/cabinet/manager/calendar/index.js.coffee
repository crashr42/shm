App.module('/cabinet/manager/calendar/index', ->
  $ = jQuery

  $('#calendar').fullCalendar
    firstDay: 1
    eventSources: [
      {
        url: '/cabinet/manager/calendar/events'
        type: 'post'
        data: id: gon.id
        error: -> alert 'there was an error while fetching events!'
      }
    ]
    eventDrop: (event, delta) -> $('#calendar').fullCalendar 'updateEvent', event
    eventClick: (event, element) ->
      $.post '/cabinet/manager/event/show', id: event.id, (request) ->
        modal = $('.modal')
        modal.find('.modal-body').first().html(request)
        modal.modal('show')
    loading: (bool) ->
      if bool
        $('#loading').show()
      else
        $('#loading').hide()
)