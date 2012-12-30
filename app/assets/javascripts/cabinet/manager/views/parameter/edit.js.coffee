define([
  'jquery',
  'backbone',
  'text!templates/select_value.html'
], ($, Backbone, SelectValueTemplate) ->
  Backbone.View.extend
    initialize: ->
      @_template = _.template(SelectValueTemplate)

    events:
      'click #select-p-add-new-value-button': 'addValue'

    addValue: (e) ->
      value = $(e.currentTarget).prev().val()
      @$el.find('#select-p-values-box').append @_template(value: value)

    render: (callback, id) ->
      $.get "/cabinet/manager/parameter/#{id}/edit", $.proxy((response) ->
        @$el.html(response)
        callback(@)
      , @)
)