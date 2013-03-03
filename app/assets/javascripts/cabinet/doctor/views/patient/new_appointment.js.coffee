define([
  'jquery',
  'backbone',
  'notification',
  'routers/router'
], ($, Backbone, Notification, Router) ->
  Backbone.View.extend

    #Patients searching
    events:
      'keyup #name': 'search'
      'click .createApptnt': 'getAppointmentCreatingForm'
      'change .controls.required': 'checkDateStartAndEnd'
      'click .btn-success': 'createAppointment'

    search: (e) ->
      form = $(e.currentTarget).parent()

      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        @$el.find('#user-main-list').html(request)
      , @)

    checkDateStartAndEnd: ->
      alert('hi')

    createAppointment: (e) ->
      e.preventDefault()
      form = @$el.find('#new_appointment_event')

      post_result = $.post(form.attr('action'), form.serialize(),
      (response) ->
        Router.instance().navigate('/cabinet/doctor/appointments', true)
        Notification.success(response)
      )

      console.log(post_result)


    getAppointmentCreatingForm: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      infoAboutPatient = '<h4>You are creating appointment for <small>' + @$el.find('.user-info#' + element.attr('id')).html() + '</small></h4>'
      @$el.find('#user-main-list').empty()
      @$el.find('#appointment-form-place').empty()
      @$el.find('#appointment-form-place').append(infoAboutPatient)
      @$el.find('#name').val('')

      $.get('/cabinet/doctor/appointments/new', $.proxy((response) ->
        @$el.find('#appointment-form-place').append(response)
        @$el.find('#patient_id').val(element.attr('id'))
        console.log(@$el.find('.controls.required').html())
      , @))


    render: (callback) ->
      $.get('/cabinet/doctor/appointment/new/get_form', $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @delegateEvents()
      , @))
)