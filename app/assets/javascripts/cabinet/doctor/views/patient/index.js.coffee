define([
  'jquery',
  'backbone',
  'routers/router',
  'text!templates/patient_list.html',
  'text!templates/patient_list_row.html'
], ($, Backbone, Router, PatientListTemplate, PatientRowTemplate) ->
  Backbone.View.extend
    initialize: ->
      @_template = _.template(PatientListTemplate)
      @_row = _.template(PatientRowTemplate)

    events:
      'click .appointment-me': 'gotoAppointmentMe'
      'click .appointment-coll': 'gotoAppointmentColleguae'
      'click .appointment-new': 'gotoAppointmentNew'
      'click .diagnostic': 'gotoDiagnostic'
      'click .diagnoses': 'gotoDiagnoses'

    gotoDiagnoses: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      Router.instance().navigate(element.attr('href'), true)

    gotoAppointmentMe: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      Router.instance().navigate(element.attr('href'), true)

    gotoAppointmentColleguae: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      Router.instance().navigate(element.attr('href'), true)

    gotoAppointmentNew: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      Router.instance().navigate(element.attr('href'), true)

    gotoDiagnostic: (e) ->
      e.preventDefault()
      element = $(e.currentTarget)
      Router.instance().navigate(element.attr('href'), true)

    render: (callback) ->
      $.getJSON '/cabinet/doctor/patient', $.proxy((response) ->
        @$el.html(@_template())
        row_render = (el, row) ->
          el.find('#patient-list').append row(p: patient) for patient in response
        row_render(@$el, @_row)
        @delegateEvents()
        callback(@)
      , @)

)