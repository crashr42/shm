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

    events:
      'click .busy': 'isBusy'
      'click .free': 'isFree'
    
    isBusy:  ->
      alert('This AppointmenrHour is busy, Please take another!')
    
    isFree: (e)->
      alert('ready to post!')

    render: (callback, id) ->
      $.getJSON '/cabinet/doctor/appointments', $.proxy((response) ->
        @$el.html(@_list())
        
	#Rendering appointment list
        row_render = (el, row) ->
          el.find('#appointment-list').append row(a: appointment) for appointment in response
        row_render(@$el, @_row)
        callback(@)
      , @)
)
