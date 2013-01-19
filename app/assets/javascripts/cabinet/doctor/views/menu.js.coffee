define([
  'jquery',
  'backbone',
  'routers/router'
], ($, Backbone, Router) ->
  Backbone.View.extend
    events:
      'click a:not([href=#])': 'goto'

    goto: (e) ->
      e.preventDefault()
      target = $(e.currentTarget)
      @removeActiveClass()
      target.parent().addClass('active')
      Router.instance().navigate(target.attr('href'), true)

    removeActiveClass: -> @$el.find('li').removeClass('active')
)