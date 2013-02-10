define([
  'jquery',
  'backbone',
  'views/index',
  'views/patient/index',
  'views/patient/appointment_me',
  'views/patient/appointment_coll',
  'views/patient/all_appointmentes'
  'views/patient/new_appointment',
  'views/diagnostic'
], ($, Backbone, Index, PatientIndex, AppointmentMe, AppointmentColl, AppointmentesAll, AppointmentNew, Diagnostic) ->
  Backbone.View.extend
    initialize: ->
      @index = new Index()
      @patientIndex = new PatientIndex()
      @appointmentMe = new AppointmentMe()
      @appointmentColl = new AppointmentColl()
      @appointmentesAll = new AppointmentesAll()
      @appointmentNew = new AppointmentNew()
      @diagnosticIndex = new Diagnostic()

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
    showPatientIndex: -> @patientIndex.render $.proxy(((v) -> @$el.html(v.el)), @)
    showAppointmentMe: (id) -> @appointmentMe.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showAppointmentColl: (id) -> @appointmentColl.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showAppointmentesAll: ->  @appointmentesAll.render $.proxy(((v) -> @$el.html(v.el)), @)
    showAppointmentNew: (id) -> @appointmentNew.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showDiagnostic: (id) -> @diagnosticIndex.render $.proxy(((v) -> @$el.html(v.el)), @), id
)