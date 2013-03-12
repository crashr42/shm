define([
  'jquery',
  'backbone',
  'views/appointment',
  'views/index',
  'views/parameter',
  'views/calendar',
  'views/doctor',
  'binder'
], (
  $,
  Backbone,
  Appointment,
  Index,
  Parameter,
  Calendar,
  Doctor,
  Binder
) ->
  Backbone.View.extend
    initialize: ->
      @appointment = new Appointment()
      @index = new Index()
      @parameter = new Parameter()
      @calendar = new Calendar()
      @doctor = new Doctor()

    viewChange: (view) -> throw 'Implementation error'

    showIndex: ->
      @index.render $.proxy (v) ->
        @$el.html v.el
        Binder.setNewContentHeight()
      , @
      @viewChange('index')

    showAppointment: ->
      @appointment.render $.proxy (v) ->
        @$el.html v.el
        Binder.setNewContentHeight()
      , @
      @viewChange('appointment')

    showParameter: ->
      @parameter.render $.proxy (v) ->
        @$el.html v.el
        Binder.setNewContentHeight()
      , @
      @viewChange('parameter')

    showCalendar: (cb) ->
      @calendar.render $.proxy (v) ->
        @$el.html v.el
        Binder.setNewContentHeight()
        cb.call(@, v) if cb
      , @
      @viewChange('calendar')

    showDoctor: ->
      @doctor.render $.proxy (v) ->
        @$el.html v.el
      , @
)