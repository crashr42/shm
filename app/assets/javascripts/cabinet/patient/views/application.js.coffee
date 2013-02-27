define([
  'jquery',
  'backbone',
  'views/menu',
  'views/content'
], ($, Backbone, Menu, Content) ->
  Backbone.View.extend
    el: 'body'

    initialize: ->
      @menu = new Menu(el: '#menu')
      @content = new Content(el: '#content')
      @content.viewChange = $.proxy (view) ->
        @menu.activateItem(view)
      , @

      @menu.render()
      @content.render()
)