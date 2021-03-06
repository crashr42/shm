define([
  'jquery',
  'backbone',
  'text!templates/appointment_list.html',
  'text!templates/appointment_expand_list_row.html',
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
      'click .expand': 'getAndExpandDoctorAppointmentsList'
      'click .hideExpand': 'hideDoctorAppointmentsList'

    isBusy: ->
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

    getAndExpandDoctorAppointmentsList: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)

      $.getJSON '/cabinet/doctor/appointments/for/' + element.attr('id'), $.proxy((response) ->
        #Rendering appointment list
        row_render = (el, row) ->
          $(row(a: appointment, dAId: element.attr('id'))).insertAfter("tr#" + element.attr('id')) for appointment in response
        row_render(@$el, @_row)
        element.attr("class", "btn btn-inverse hideExpand")
        element.html("Скрыть")
      , @)

    hideDoctorAppointmentsList: (e) ->
       e.preventDefault()
       element = $(e.currentTarget)
       $('.doctorAppointmentsId' + element.attr('id')).remove()
       element.attr("class", "btn btn-primary expand")
       element.html("Назначить")

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
