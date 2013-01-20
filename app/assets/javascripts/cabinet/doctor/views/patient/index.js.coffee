define([
  'jquery',
  'backbone',
  'text!templates/patient_list.html',
  'text!templates/patient_list_row.html'
], ($, Backbone, PatientListTemplate, PatientRowTemplate) ->
  Backbone.View.extend
    initialize: ->
      @_template = _.template(PatientListTemplate)
      @_row = _.template(PatientRowTemplate)

    render: (callback) ->
      $.getJSON '/cabinet/doctor/patient', $.proxy((response) ->
        @$el.html(@_template())
        #@$el("#patient-list").append @_row(p: patient) for patient in response
        row_render = (el, row) ->
          el.find('#patient-list').append row(p: patient) for patient in response
        row_render(@$el, @_row)
        callback(@)
      , @)

)