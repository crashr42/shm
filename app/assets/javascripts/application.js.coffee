require.config
  baseUrl: '/assets'
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
    'bootstrap-datepicker':
      deps: ['jquery']
    'bootstrap-timepicker':
      deps: ['jquery']

define([
  'binder',
  'ajax',
  'jquery_ujs',
  'backbone_rails_sync',
  'backbone_datalink'
], (Binder) ->
  class App
    constructor: ->
      Binder.bind()

  App
)