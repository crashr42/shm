define([
  'jquery',
  'backbone',
  'notification'
], ($, Backbone, Notification) ->
  Backbone.View.extend
    events:
      'click .btn': 'save'

    save: (e) ->
      e.preventDefault()
      form = @$el.find('form')
      $.post(form.attr('action'), form.serialize(), (request) -> Notification.success(request.message))
)