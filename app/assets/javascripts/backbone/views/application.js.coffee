Shm.Views.Application = Backbone.View.extend
  el: 'body'

  initialize: ->
    (@menu = new Shm.Views.Menu({el: '#menu'})).render()
    (@content = new Shm.Views.Content({el: '#content'})).render()