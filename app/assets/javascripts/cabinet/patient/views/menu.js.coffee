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
      @activateItem(target.attr('data-view'))
      Router.instance().navigate(target.attr('href'), true)

    activateItem: (item) ->
      @$el.find('li').removeClass('active')
      @$el.find("a[data-view=#{item}]").parent().addClass('active')
)