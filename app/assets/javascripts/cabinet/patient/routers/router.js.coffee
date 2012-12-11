define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Router = Backbone.Router.extend
    initialize: (options) -> @app = options.app

    routes:
      'cabinet/patient': 'index'
      'cabinet/patient/appointment': 'appointment'
      'cabinet/patient/parameter': 'parameter'
      'cabinet/patient/calendar': 'calendar'
      'cabinet/patient/doctor': 'doctor'

    index: -> @app.content.showIndex()
    appointment: -> @app.content.showAppointment()
    parameter: -> @app.content.showParameter()
    calendar: -> @app.content.showCalendar()
    doctor: -> @app.content.showDoctor()

  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)