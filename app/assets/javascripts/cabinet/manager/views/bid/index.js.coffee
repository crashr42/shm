define([
  'jquery',
  'backbone',
  'routers/router'
], ($, Backbone, Router) ->
  Backbone.View.extend
    events:
      'click a.bid-show': 'showBid'

    showBid: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      Router.instance().navigate(element.attr('href'), true)

    render: (callback) ->
      $.get '/cabinet/manager/bid', $.proxy((request) ->
        @$el.html(request)
        @delegateEvents()
        callback(@)
      , @)
)