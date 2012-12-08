Shm.Views.Menu = Backbone.View.extend
  events:
    'click a': 'goto'

  goto: (e) ->
    e.preventDefault()
    target = $(e.currentTarget)
    @removeActiveClass()
    target.parent().addClass('active')
    Shm.Routers.Default.instance().navigate(target.attr('href'), true)

  removeActiveClass: ->
    @$el.find('li').removeClass('active')