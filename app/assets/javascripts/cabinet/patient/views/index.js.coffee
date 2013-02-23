define([
  'jquery',
  'backbone',
  'routers/router'
], ($, Backbone, Router) ->
  Backbone.View.extend
    events:
      'click .hajax': 'handleAsAjax'

    handleAsAjax: (e) ->
      e.preventDefault()
      target = $(e.currentTarget)
      Router.instance().navigate(target.attr('href'), true)

    render: (callback) ->
      $.get('/cabinet/patient', $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @delegateEvents()
      , @))
)