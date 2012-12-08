#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.Shm =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$(document).ready ->
  (app = new Shm.Views.Application()).render()
  Shm.Routers.Default.instance(app: app)
  Backbone.history.start(pushState: true)