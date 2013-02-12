define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    events:
      'click .event': 'showEventInfo'

    showEventInfo: (e) ->
      @current_event_id = $(e.currentTarget).attr('data-id')
      $.post('/cabinet/patient/event/documents', {id: @current_event_id}, $.proxy((response) ->
        @$el.find('.event-info').html(response)
      , @))

    render: (callback) ->
      $.get('/cabinet/patient/event/history', $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @))
)