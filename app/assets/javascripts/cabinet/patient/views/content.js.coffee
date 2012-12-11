define([
  'jquery',
  'backbone',
  'views/appointment',
  'views/index',
  'views/parameter',
  'views/calendar'
], (
  $,
  Backbone,
  Appointment,
  Index,
  Parameter,
  Calendar
) ->
  Backbone.View.extend
    initialize: ->
      @appointment = new Appointment(parentView: @)
      @index = new Index(parentView: @)
      @parameter = new Parameter(parentView: @)
      @calendar = new Calendar(parentView: @)

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
    showAppointment: -> @appointment.render $.proxy(((v) -> @$el.html(v.el)), @)
    showParameter: -> @parameter.render $.proxy(((v) -> @$el.html(v.el)), @)
    showCalendar: -> @calendar.render $.proxy(((v) -> @$el.html(v.el);  @calendar.bindCalendar()), @)
)