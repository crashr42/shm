define([
   'jquery',
   'backbone',
   'notification',
   'routers/router'
 ], ($, Backbone, Notification, Router) ->
  Backbone.View.extend

    events:
      'click .btn-success': 'createAppointment'

    createAppointment: (e) ->
      e.preventDefault()
      form = @$el.find('#new_appointment_event')

      $.post(form.attr('action'), form.serialize(),
      (response) ->
        Router.instance().navigate('/cabinet/doctor/appointments', true)
        Notification.success(response)
      )

    render: (callback, id) ->
      $.get('/cabinet/doctor/appointments/new', $.proxy((response) ->
        @$el.html(response)
        @$el.find('#patient_id').val(id)
        callback(@)
        @delegateEvents()
      , @))
)