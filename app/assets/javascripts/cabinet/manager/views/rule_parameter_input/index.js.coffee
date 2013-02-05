define([
  'jquery',
  'backbone',
  'routers/router'
], ($, Backbone, Router) ->
  Backbone.View.extend
    render: (callback) ->
      $.get '/cabinet/manager/rule_parameter_input', $.proxy((response) ->
        @$el.html(response)
        @delegateEvents()
        callback(@)
      , @)
)