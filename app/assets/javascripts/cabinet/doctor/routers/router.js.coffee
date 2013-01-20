define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Router = Backbone.Router.extend
    initialize: (options) -> @app = options.app

    routes:
      'cabinet/doctor': 'index'
      'cabinet/doctor/patient': 'patientIndex'

    index: -> @app.content.showIndex()
    patientIndex: -> @app.content.showPatientIndex()


  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)