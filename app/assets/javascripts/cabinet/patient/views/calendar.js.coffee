define([
  'jquery',
  'backbone',
  'fullcalendar',
  'bootstrap'
], ($, Backbone) ->
  Backbone.View.extend
    render: (callback) ->
      $.get('/cabinet/patient/calendar', $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @bindCalendar()
      , @))

    bindCalendar: ->
      that = @
      @$el.find('#calendar').fullCalendar
        firstDay: 1
        eventSources: [
          {
          url: '/cabinet/patient/event.json'
          type: 'get'
          error: -> alert 'there was an error while fetching events!'
          }
        ]
        eventDrop: (event, delta) -> that.$el.find('#calendar').fullCalendar 'updateEvent', event
        eventClick: (event, element) ->
          $.get '/cabinet/patient/event/show/' + event.id, (request) ->
            modal = that.$el.find('.modal')
            modal.find('.modal-body').first().html(request)
            modal.modal('show')
)