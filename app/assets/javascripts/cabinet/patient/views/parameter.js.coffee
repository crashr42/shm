define([
  'jquery',
  'backbone',
  'routers/router'
], ($, Backbone, Router) ->
  Backbone.View.extend
    events:
      'click a': 'goto'

    render: (callback) ->
      return callback(@) unless @$el.empty()

      $.get('/cabinet/patient/parameter', $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @))

    goto: (e) ->
      e.preventDefault()
      Router.instance().navigate($(e.currentTarget).attr('href'), true)
)