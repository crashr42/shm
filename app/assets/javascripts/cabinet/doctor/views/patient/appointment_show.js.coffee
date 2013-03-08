define([
  'jquery',
  'backbone',
], ($, Backbone) ->
  Backbone.View.extend

    events:
      'click .stop-appointment': 'stop_appointment'
      'click .start-appointment': 'start_appointment'

    stop_appointment: (e) ->
      e.preventDefault()
      alert 'you clicked stop button!'

    start_appointment: (e) ->
      e.preventDefault()
      alert 'you clicked start button!'

    render: (callback, id) ->
      $.get("/cabinet/doctor/appointments/#{id}", $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @delegateEvents()
      , @))

)