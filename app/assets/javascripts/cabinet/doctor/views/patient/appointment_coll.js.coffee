define([
  'jquery',
  'backbone',
  'text!templates/appointment_list.html',
  'text!templates/appointment_list_row.html',
  'text!templates/doctors_list.html',
  'text!templates/doctor_list_row.html',
  'routers/router'
], ($, Backbone, AppointmentListTemplate, AppointmentListRowTemplate, DoctorsListTemplate, DoctorListRowTemplate, Router) ->
  Backbone.View.extend

    initialize: ->
      @_list = _.template(AppointmentListTemplate)
      @_row = _.template(AppointmentListRowTemplate)

      @_doctors_list = _.template(DoctorsListTemplate)
      @_doctor_list_row = _.template(DoctorListRowTemplate)

    events:
      'click .busy': 'isBusy'
      'click .free': 'isFree'
      'click .expand': 'getDoctors'

    isBusy:  ->
      alert('This AppointmenrHour is busy, Please take another!')

    isFree: (e)->
      e.preventDefault()
      element = $(e.currentTarget)
      ajax_param =
        url: '/cabinet/doctor/appointment/confirm'
        type: 'post'
        dataType: 'text'
        data:
          apptId: element.attr('id')
          patId: document.patient_id
        success: (data) ->
          alert(data)
          Router.instance().navigate('/cabinet/doctor/patient', true)

      $.ajax ajax_param

    getDoctors: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)

      $.getJSON '/cabinet/doctor/appointments/' + element.attr('id'), $.proxy((response) ->
        #Rendering appointment list
        row_render = (el, row) ->
          $('<tr><td colspan="4">' + row(a: appointment) + '</td></tr>').insertAfter("tr#" + element.attr('id')) for appointment in response
        row_render(@$el, @_row)
      , @)

    render: (callback, id) ->
      document.patient_id = id
      $.getJSON '/cabinet/doctor/users/doctors', $.proxy((response) ->
        @$el.html(@_doctors_list)
        #Rendering appointment list
        row_render = (el, row) ->
          el.find('#doctors-list').append row(d: doctor) for doctor in response
        row_render(@$el, @_doctor_list_row)
        callback(@)
      , @)
)
