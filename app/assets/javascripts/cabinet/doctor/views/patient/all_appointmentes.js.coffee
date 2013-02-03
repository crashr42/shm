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

    render: (callback, id) ->
      document.patient_id = id
      $.getJSON '/cabinet/doctor/appointments', $.proxy((response) ->
        @$el.html(@_list())
        #Rendering appointment list
        row_render = (el, row) ->
          el.find('#appointment-list').append row(a: appointment) for appointment in response
        row_render(@$el, @_row)
        callback(@)
      , @)
)
