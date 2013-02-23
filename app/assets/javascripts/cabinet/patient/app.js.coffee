require.config
  urlArgs: 'v=' + Math.random()
  baseUrl: '/assets'
  paths:
    app: 'cabinet/patient'
    views: 'cabinet/patient/views'
    routers: 'cabinet/patient/routers'
    templates: 'cabinet/patient/templates'
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
    page_size:
      deps: ['jquery']
    highcharts:
      exports: 'Highcharts'
    highstock:
      exports: 'Highcharts'

require([
  'application',
  'jquery',
  'backbone',
  'views/application',
  'routers/router',
  'rails',
  'blocker'
], (App, $, Backbone, Application, Router, Rails, Blocker) ->
  class PatientCabinet extends App
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

  new PatientCabinet()
)