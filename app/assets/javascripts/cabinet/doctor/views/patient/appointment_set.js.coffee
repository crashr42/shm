define([
  'jquery',
  'backbone',
], ($, Backbone) ->
  Backbone.View.extend

  #Patients searching
    events:
      'keyup #name': 'search'
    search: (e) ->
      form = $(e.currentTarget).parent()

      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        @$el.find('#user-main-list').html(request)
      , @)


    render: (callback) ->
      $.get('/cabinet/doctor/appointment/new/get_form2', $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @delegateEvents()
      , @))
)