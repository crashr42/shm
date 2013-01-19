define([
  'jquery',
  'backbone',
  'views/index',
], ($, Backbone, Index, User, ParameterIndex, ParameterEdit, ParameterNew, BidIndex, BidShow) ->
  Backbone.View.extend
    initialize: ->
      @index = new Index()

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
)