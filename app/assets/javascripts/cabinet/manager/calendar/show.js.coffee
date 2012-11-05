App.module('/cabinet/manager/calendar/show', ->
  $ = jQuery

  $('#calendar').fullCalendar
    firstDay: 1
    eventSources: [
      {
      url: '/cabinet/manager/event.json'
      type: 'get'
      data: id: gon.id
      error: -> alert 'there was an error while fetching events!'
      }
    ]
    eventDrop: (event, delta) -> $('#calendar').fullCalendar 'updateEvent', event
    eventClick: (event, element) ->
      $.get '/cabinet/manager/event/show/' + event.id, (request) ->
        modal = $('.modal')
        modal.find('.modal-body').first().html(request)
        modal.modal('show')
    loading: (bool) ->
      if bool
        $('#loading').show()
      else
        $('#loading').hide()
)