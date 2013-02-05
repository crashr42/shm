define([
  'jquery',
  'backbone',
], ($, Backbone) ->
  Backbone.View.extend

    render: (callback) ->
      $.get('/cabinet/manager/event/new', $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @))
)