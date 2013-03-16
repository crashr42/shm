define([
  'jquery',
  'backbone',
  'routers/router',
], ($, Backbone, Router) ->
  Backbone.View.extend

    events:
      'keyup #diagnose-name': 'search'

    search: (e)->
      form = $(e.currentTarget).parent()

      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        @$el.find('#diagnoses-list').html(request)
      , @)


    render: (callback, id) ->
      $.get "/cabinet/doctor/diagnoses/get-form/patient/#{id}", $.proxy((response) ->

        @$el.html(response)

        @delegateEvents()
        callback(@)
      , @)
)