define([
  'jquery',
  'backbone',
], ($, Backbone) ->
  Backbone.View.extend

    render: (callback) ->
      $.get('/cabinet/doctor', $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @))
)