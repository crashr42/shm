define([
  'jquery',
  'backbone',
  'routers/router'
], ($, Backbone, Router) ->
  Backbone.View.extend
    events:
      'click a.parameter-edit': 'gotoEditParameter'

    gotoEditParameter: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      Router.instance().navigate(element.attr('href'), true)

    render: (callback) ->
      $.get '/cabinet/manager/parameter', $.proxy((response) ->
        @$el.html(response)
        @delegateEvents()
        callback(@)
      , @)
)