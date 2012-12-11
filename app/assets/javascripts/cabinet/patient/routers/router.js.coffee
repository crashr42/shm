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

    index: -> @app.content.showIndex()
    appointment: -> @app.content.showAppointment()
    parameter: -> @app.content.showParameter()
    calendar: -> @app.content.showCalendar()

  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)