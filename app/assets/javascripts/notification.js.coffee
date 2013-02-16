define([
  'jquery',
  'backbone',
  'gritter'
], ($, Backbone) ->
  Notification = Backbone.View.extend
    el: '#notification'

    message: (message, type) ->
      $.gritter.add
        title: type
        text: message
        time: 10000

    success: (message) -> @message(message, 'success')
    alert: (message) -> @message(message, 'alert')
    error: (message) -> @message(message, 'error')

  new Notification()
)