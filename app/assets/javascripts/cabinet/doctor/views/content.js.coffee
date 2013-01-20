define([
  'jquery',
  'backbone',
  'views/index',
  'views/patient/index'
], ($, Backbone, Index, PatientIndex) ->
  Backbone.View.extend
    initialize: ->
      @index = new Index()
      @patientIndex = new PatientIndex()

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
    showPatientIndex: -> @patientIndex.render $.proxy(((v) -> @$el.html(v.el)), @)
)