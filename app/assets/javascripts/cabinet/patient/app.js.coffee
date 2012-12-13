require.config(
  baseUrl: '/assets'
  paths:
    app: 'cabinet/patient'
    views: 'cabinet/patient/views'
    routers: 'cabinet/patient/routers'
    templates: 'cabinet/patient/templates'
  shim:
    underscore:
      exports: '_'
    backbone:
      deps: ['jquery', 'underscore']
      exports: 'Backbone'
    fullcalendar:
      deps: ['jquery']
      exports: 'Fullcalendar'
    ajax:
      deps: ['jquery']
      exports: 'ajax'
    rails:
      exports: 'Rails'
    bootstrap:
      deps: ['jquery']
      exports: 'Bootstrap'
)

require([
  'jquery',
  'backbone',
  'views/application',
  'routers/router',
  'blocker'
  'ajax',
  'jquery_ujs'
], ($, Backbone, Application, Router, Blocker) ->
  $(document).ready ->
    Router.instance(app: new Application())
    Backbone.history.start(pushState: true)
    Blocker.start()
)