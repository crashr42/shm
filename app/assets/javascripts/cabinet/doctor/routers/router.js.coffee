define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Router = Backbone.Router.extend
    initialize: (options) -> @app = options.app

    routes:
      'cabinet/doctor': 'index'
      'cabinet/doctor/patient': 'patientIndex'
      'cabinet/doctor/appointment/me/:id': 'appointmentMe'
      'cabinet/doctor/appointment/colleague/:id': 'appointmentColl'
      'cabinet/doctor/appointments': 'appointmentesAll'
      'cabinet/doctor/appointment/new': 'appointmentNew'

    index: -> @app.content.showIndex()
    patientIndex: -> @app.content.showPatientIndex()
    appointmentMe: (id) -> @app.content.showAppointmentMe(id)
    appointmentColl: (id) -> @app.content.showAppointmentColl(id)
    appointmentesAll: -> @app.content.showAppointmentesAll()
    appointmentNew: -> @app.content.showAppointmentNew()

  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)