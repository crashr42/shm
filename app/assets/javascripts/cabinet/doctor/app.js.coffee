require.config
  baseUrl: '/assets'
  paths:
    app: 'cabinet/doctor'
    views: 'cabinet/doctor/views'
    routers: 'cabinet/doctor/routers'
    templates: 'cabinet/doctor/templates'
  shim:
    underscore:
      exports: '_'
    backbone_datalink:
      deps: ['jquery', 'underscore', 'backbone']
    backbone_rails_sync:
      deps: ['jquery', 'underscore', 'backbone']
    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'

require([
  'application',
  'jquery',
  'backbone',
  'views/application',
  'routers/router',
  'rails',
  'blocker',
  'bootstrap'
], (App, $, Backbone, Application, Router, Rails, Blocker) ->
  class DoctorCabinet extends App
    constructor: ->
      $(document).ready $.proxy( ->
        super()
        # главный роут
        Router.instance(app: new Application())
        # запускаем прослушку истории
        Backbone.history.start(pushState: true)
        # блокировка при таймауте
        Blocker.start() unless Rails.env == 'development'
      , @)

  new DoctorCabinet()
)