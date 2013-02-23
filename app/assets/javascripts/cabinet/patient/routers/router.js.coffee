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
      'cabinet/patient/doctor': 'doctor'
      'cabinet/patient/event/history': 'history'
      'cabinet/patient/event/history/:id': 'eventHistory'
      'cabinet/patient/event/history/:id/:document': 'documentHistory'

    index: -> @app.content.showIndex()
    appointment: -> @app.content.showAppointment()
    parameter: -> @app.content.showParameter()
    calendar: -> @app.content.showCalendar()
    doctor: -> @app.content.showDoctor()
    history: ->
      @app.content.showHistory (v) ->

    eventHistory: (id) ->
      @app.content.showHistory (v) ->
        v.showEventInfo(id)

    documentHistory: (id, document) ->
      @app.content.showHistory (v) ->
        @$el.html(v.el)
        v.showEventInfo(id)
        v.showDocumentInfo(document)

  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)