define([
  'jquery',
  'backbone',
  'text!templates/appointment_list.html',
  'text!templates/appointment_list_row.html',
  'routers/router'
], ($, Backbone, AppointmentListTemplate, AppointmentListRowTemplate, Router) ->
  Backbone.View.extend

    initialize: ->
      @_list = _.template(AppointmentListTemplate)
      @_row = _.template(AppointmentListRowTemplate)

    events:
      'click .busy': 'isBusy'
      'click .free': 'isFree'
    
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

    render: (callback, id) ->
      document.patient_id = id
      $.getJSON '/cabinet/doctor/appointments/for/me', $.proxy((response) ->
        @$el.html(@_list())

	      #Rendering appointment list
        row_render = (el, row) ->
          el.find('#appointment-list').append row(a: appointment) for appointment in response
        row_render(@$el, @_row)
        callback(@)
      , @)
)
