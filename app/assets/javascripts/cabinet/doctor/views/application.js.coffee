define([
  'jquery',
  'backbone',
  'views/menu',
  'views/content'
], ($, Backbone, Menu, Content) ->
  Backbone.View.extend
    el: 'body'

    initialize: ->
      (@menu = new Menu({el: '#menu'})).render()
      (@content = new Content({el: '#content'})).render()
)