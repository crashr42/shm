define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    render: (callback) ->
      $.get('/cabinet/patient', $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @))
)