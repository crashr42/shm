define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    render: (callback) ->
      $.get('/cabinet/manager', $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @))
)