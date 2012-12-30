define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    events:
      'keyup #name': 'search'

    search: (e) ->
      form = $(e.currentTarget).parent()
      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        @$el.find('#user-main-list').html(request)
      , @)

    render: (callback) ->
      return callback(@) unless @$el.empty()

      $.get('/cabinet/manager/user', $.proxy((response) ->
        @$el.html(response)
        @delegateEvents()
        callback(@)
      , @))
)