define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    events:
      'click .parameter': 'showParameterDiagnostic'

    showParameterDiagnostic: (e) ->
      id = $(e.currentTarget).attr('data-id')
      @$el.find('.parameter-diagnostic').append("Selected parameter: #{id}")

    render: (callback, id) ->
      $.get("/cabinet/doctor/diagnostic/show/#{id}", $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @))
)