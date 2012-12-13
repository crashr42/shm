define([
  'jquery',
  'backbone',
  'text!templates/success.html',
  'text!templates/info.html'
  'text!templates/alert.html'
], ($, Backbone, success, info, alert) ->
  Notification = Backbone.View.extend
    el: '#notification'

    success: (message) -> @$el.html(_.template(success)(message: message))
    info: (message) -> @$el.html(_.template(info)(message: message))
    alert: (message) -> @$el.html(_.template(alert)(message: message))

  new Notification()
)