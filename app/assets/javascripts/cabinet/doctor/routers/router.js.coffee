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
      'cabinet/doctor/patient/new': 'appointmentSet'
      'cabinet/doctor/appointments': 'appointmentesAll'
      'cabinet/doctor/appointment/new': 'appointmentNew'
      'cabinet/doctor/appointment/new/:id': 'appointmentNewFor'
      'cabinet/doctor/appointments/:id': 'appointmentShow'
      'cabinet/doctor/diagnostic/:id': 'diagnostic'

    index: -> @app.content.showIndex()
    patientIndex: -> @app.content.showPatientIndex()
    appointmentMe: (id) -> @app.content.showAppointmentMe(id)
    appointmentColl: (id) -> @app.content.showAppointmentColl(id)
    appointmentSet: -> @app.content.showAppointmentSet()
    appointmentesAll: -> @app.content.showAppointmentesAll()
    appointmentNew:  -> @app.content.showAppointmentNew()
    appointmentNewFor: (id) -> @app.content.showApoointmentFor(id)
    appointmentShow: (id) -> @app.content.showAppointmentShow(id)
    diagnostic: (id) -> @app.content.showDiagnostic(id)

  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)