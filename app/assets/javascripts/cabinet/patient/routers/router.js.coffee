define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Router = Backbone.Router.extend
    initialize: (options) ->
      @app = options.app

    routes:
      'cabinet/patient': 'index'
      'cabinet/patient/appointment': 'appointment'
      'cabinet/patient/parameter': 'parameter'
      'cabinet/patient/calendar': 'calendar'
      'cabinet/patient/calendar/:id': 'calendarEvent'
      'cabinet/patient/doctor': 'doctor'

    index: -> @app.content.showIndex()
    appointment: -> @app.content.showAppointment()
    parameter: -> @app.content.showParameter()
    doctor: -> @app.content.showDoctor()

    calendar: -> @app.content.showCalendar()
    calendarEvent: (id) ->
      @app.content.showCalendar (v) ->
        v.showEventInfo(id)

  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)