define([
  'jquery',
  'backbone',
], ($, Backbone) ->
  Backbone.View.extend

    events:
      'click .stop-appointment': 'stop_appointment'
      'click .start-appointment': 'start_appointment'
      'click .add-link': 'addMedicament'
      'click .start-search': 'search'
      'click .send': 'saveMedicaments'

    addMedicament: (e)->
      e.preventDefault()
      element = $(e.currentTarget)

      inserted_text = @$el.find(".medicament##{element.attr('id')}").html()

      @$('#existing-medicaments').append('<p><input type="checkbox" checked="checked"  name="item[]" value="' + element.attr('id') + '" />')
      @$('#existing-medicaments').append("#{inserted_text} </p>")
      @$('#existing-medicaments').append('<br />')

    search: (e)->
      form = $(e.currentTarget).parent()

      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        @$el.find('#medicaments-list').html(request)
      , @)

    saveMedicaments: (e)->
      e.preventDefault()
      form = $(e.currentTarget).parent().parent()

      $.post form.attr('action'), form.serialize(), $.proxy((request) ->
        alert(request)
        location.reload()
      , @)

    stop_appointment: (e) ->
      e.preventDefault()
      target = $(e.currentTarget)
      $.get "/cabinet/doctor/appointment/stop_appointment/#{target.attr('id')}", (response) ->
        alert(response)
        location.reload()

    start_appointment: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      $.get "/cabinet/doctor/appointment/start_appointment/#{element.attr('id')}", (response) ->
        alert(response)
        location.reload()

    render: (callback, id) ->
      $.get("/cabinet/doctor/appointments/#{id}", $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @delegateEvents()
      , @))

)