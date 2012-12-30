define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    render: (callback, id) ->
      $.get "/cabinet/manager/bid/#{id}", $.proxy((request) ->
        @$el.html(request)
        callback(@)
      , @)
)