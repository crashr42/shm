require.config
  urlArgs: 'v=' + Math.random()
  baseUrl: '/assets'
  paths:
    app: 'cabinet/manager'
    views: 'cabinet/manager/views'
    routers: 'cabinet/manager/routers'
    templates: 'cabinet/manager/templates'
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
    bootstrap:
      deps: ['jquery']

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
  class ManagerCabinet extends App
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

  new ManagerCabinet()
)