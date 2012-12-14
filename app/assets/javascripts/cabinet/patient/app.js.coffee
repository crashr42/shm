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
    backbone_datalink:
      deps: ['jquery', 'underscore']
    backbone_rails_sync:
      deps: ['jquery', 'underscore']
    backbone:
      deps: ['jquery', 'underscore', 'backbone_datalink', 'backbone_rails_sync']
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
  'rails',
  'blocker'
  'ajax',
  'jquery_ujs'
], ($, Backbone, Application, Router, Rails, Blocker) ->
  $(document).ready ->
    Router.instance(app: new Application())
    Backbone.history.start(pushState: true)
    Blocker.start() unless Rails.env == 'development'
)