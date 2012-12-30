define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Router = Backbone.Router.extend
    initialize: (options) -> @app = options.app

    routes:
      'cabinet/manager': 'index'
      'cabinet/manager/user': 'user'
      'cabinet/manager/parameter': 'parameterIndex'
      'cabinet/manager/parameter/:id/edit': 'parameterEdit'
      'cabinet/manager/parameter/new': 'parameterNew'

    index: -> @app.content.showIndex()
    user: -> @app.content.showUser()
    parameterIndex: -> @app.content.showParameterIndex()
    parameterEdit: (id) -> @app.content.showParameterEdit(id)
    parameterNew: -> @app.content.showParameterNew()

  Router.instance = (options) -> @_instance || (@_instance = new Router(options))

  Router
)