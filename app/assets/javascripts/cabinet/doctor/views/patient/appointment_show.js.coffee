define([
  'jquery',
  'backbone',
], ($, Backbone) ->
  Backbone.View.extend

    render: (callback, id) ->
      $.get("/cabinet/doctor/appointments/#{id}", $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @delegateEvents()
      , @))

)