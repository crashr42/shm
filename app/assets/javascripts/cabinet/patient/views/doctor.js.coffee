define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    events:
      'click .show-doctor-info': 'show'

    show: (e) ->
      e.preventDefault()
      $.get('/cabinet/patient/doctor/show/' + $(e.currentTarget).attr('data-id'), $.proxy((request) ->
        @$el.find('#doctor-info-box').html(request)
      , @))

    render: (callback) ->
      $.get('/cabinet/patient/doctor', $.proxy((request) ->
        @$el.html(request)
        callback(@)
      , @))
)