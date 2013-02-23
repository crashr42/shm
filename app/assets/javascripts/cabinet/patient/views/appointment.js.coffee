define([
  'jquery',
  'backbone',
  'views/appointment/result',
  'views/appointment/toolbar'
], ($, Backbone, Result, Toolbar) ->
  Backbone.View.extend
    render: (callback) ->
      return callback(@) unless @$el.empty()

      $.get '/cabinet/patient/appointment', $.proxy (request) ->
        @$el.html(request)

        @toolbar = new Toolbar el: @$el.find('#toolbar')
        @result = new Result el: @$el.find('#result')

        @toolbar.delegateEvents()
        @toolbar.selected = $.proxy (id, date) ->
          @result.render(id, date)
        , @

        callback(@)
      , @
)