define([
  'jquery',
  'backbone',
  'routers/router',
], ($, Backbone, Router) ->
  Backbone.View.extend

    render: (callback, id) ->
      $.getJSON "/cabinet/doctor/diagnoses/#{id}", $.proxy((response) ->

        console.log response

        @delegateEvents()
        callback(@)
      , @)
)