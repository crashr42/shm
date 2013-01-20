define([
  'jquery',
  'backbone',
  'text!templates/appointment_list.html',
  'text!templates/appointment_list_row.html'
], ($, Backbone, AppointmentListTemplate, AppointmentListRowTemplate) ->
  Backbone.View.extend

    initialize: ->
      @_list = _.template(AppointmentListTemplate)
      @_row = _.template(AppointmentListRowTemplate)

    render: (callback, id) ->
      $.getJSON '/cabinet/doctor/appointments', $.proxy((response) ->
        @$el.html(@_list())
        callback(@)
      , @)
)