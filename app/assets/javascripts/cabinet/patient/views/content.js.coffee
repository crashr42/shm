define([
  'jquery',
  'backbone',
  'views/appointment',
  'views/index',
  'views/parameter',
  'views/calendar',
  'views/doctor'
], (
  $,
  Backbone,
  Appointment,
  Index,
  Parameter,
  Calendar,
  Doctor
) ->
  Backbone.View.extend
    initialize: ->
      @appointment = new Appointment(parentView: @)
      @index = new Index(parentView: @)
      @parameter = new Parameter(parentView: @)
      @calendar = new Calendar(parentView: @)
      @doctor = new Doctor(parentView: @)

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
    showAppointment: -> @appointment.render $.proxy(((v) -> @$el.html(v.el)), @)
    showParameter: -> @parameter.render $.proxy(((v) -> @$el.html(v.el)), @)
    showCalendar: -> @calendar.render $.proxy(((v) -> @$el.html(v.el);  @calendar.bindCalendar()), @)
    showDoctor: -> @doctor.render $.proxy(((v) -> @$el.html(v.el)), @)
)