define([
  'jquery',
  'backbone',
  'routers/router',
], ($, Backbone, Router) ->
  Backbone.View.extend

    events:
      'click .start-search': 'search'
      'click .add-link': 'addDiagnose'
      'click .send': 'saveDiagnoses'

    addDiagnose: (e)->
      e.preventDefault()
      element = $(e.currentTarget)

      inserted_text = @$el.find(".diagnose##{element.attr('id')}").html()

      @$('#existing-diagnoses').append('<p><input type="checkbox" checked="checked"  name="item[]" value="' + element.attr('id') + '" />')
      @$('#existing-diagnoses').append("#{inserted_text} </p>")
      @$('#existing-diagnoses').append('<br />')

    search: (e)->
      form = $(e.currentTarget).parent()

      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        @$el.find('#diagnoses-list').html(request)
      , @)

    saveDiagnoses: (e)->
      e.preventDefault()
      form = $(e.currentTarget).parent().parent()

      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        alert(request)
        location.reload()
      , @)



    render: (callback, id) ->
      $.get "/cabinet/doctor/diagnoses/get-form/patient/#{id}", $.proxy((response) ->

        @$el.html(response)

        @delegateEvents()
        callback(@)
      , @)
)