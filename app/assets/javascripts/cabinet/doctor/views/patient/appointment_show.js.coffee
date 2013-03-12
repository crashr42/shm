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
      target = $(e.currentTarget)
      $.get "/cabinet/doctor/appointment/stop_appointment/#{target.attr('id')}", (response) ->
        alert(response)
        location.reload()

    start_appointment: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      $.get "/cabinet/doctor/appointment/start_appointment/#{element.attr('id')}", (response) ->
        alert(response)
        location.reload()

    render: (callback, id) ->
      $.get("/cabinet/doctor/appointments/#{id}", $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @delegateEvents()
      , @))

)