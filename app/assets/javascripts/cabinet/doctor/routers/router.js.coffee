define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Router = Backbone.Router.extend
    initialize: (options) -> @app = options.app

    routes:
      'cabinet/doctor': 'index'

    index: -> @app.content.showIndex()


  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)