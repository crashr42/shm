define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    events:
      'click .btn': 'save'

    save: (e) ->
      e.preventDefault()
      form = @$el.find('form')
      $.post(form.attr('href'), form.serialize(), (request) -> alert('saved'))
)