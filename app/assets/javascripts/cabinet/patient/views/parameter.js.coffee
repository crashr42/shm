define([
  'jquery',
  'backbone',
  'routers/router',
  'views/parameter/form'
], ($, Backbone, Router, Form) ->
  Backbone.View.extend
    events:
      'click a': 'goto'

    render: (callback) ->
      return callback(@) unless @$el.empty()

      $.get '/cabinet/patient/parameter', $.proxy (response) ->
        @$el.html(response)
        @initializeForms()
        callback(@)
      , @

    initializeForms: -> $.each @$el.find('.parameter'), (i, e) -> new Form(el: e)

    goto: (e) ->
      e.preventDefault()
      Router.instance().navigate($(e.currentTarget).attr('href'), true)
)