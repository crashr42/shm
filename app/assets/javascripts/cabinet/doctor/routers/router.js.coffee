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

    index: -> @app.content.showIndex()
    patientIndex: -> @app.content.showPatientIndex()
    appointmentMe: (id) -> @app.content.showAppointmentMe(id)


  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)