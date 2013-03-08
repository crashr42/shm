define([
  'jquery',
  'backbone',
  'views/index',
  'views/patient/index',
  'views/patient/appointment_me',
  'views/patient/appointment_coll',
  'views/patient/appointment_set',
  'views/patient/all_appointmentes'
  'views/patient/new_appointment',
  'views/patient/new_appointment_for',
  'views/patient/new_appointment_show'
  'views/diagnostic'
], ($, Backbone, Index, PatientIndex, AppointmentMe, AppointmentColl, AppointmentSet, AppointmentesAll, AppointmentNew, AppointmentFor, AppointmentShow, Diagnostic) ->
  Backbone.View.extend
    initialize: ->
      @index = new Index()
      @patientIndex = new PatientIndex()
      @appointmentMe = new AppointmentMe()
      @appointmentColl = new AppointmentColl()
      @appointmentSet = new AppointmentSet()
      @appointmentesAll = new AppointmentesAll()
      @appointmentNew = new AppointmentNew()
      @appointmentFor = new AppointmentFor()
      @appointmentShow = new AppointmentShow()
      @diagnosticIndex = new Diagnostic()

    showIndex: -> @index.render $.proxy(((v) -> @$el.html(v.el)), @)
    showPatientIndex: -> @patientIndex.render $.proxy(((v) -> @$el.html(v.el)), @)
    showAppointmentMe: (id) -> @appointmentMe.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showAppointmentColl: (id) -> @appointmentColl.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showAppointmentSet: -> @appointmentSet.render $.proxy(((v) -> @$el.html(v.el)), @)
    showAppointmentesAll: ->  @appointmentesAll.render $.proxy(((v) -> @$el.html(v.el)), @)
    showAppointmentNew: -> @appointmentNew.render $.proxy(((v) -> @$el.html(v.el)), @)
    showApoointmentFor: (id) -> @appointmentFor.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showAppointmentShow: (id) -> @appointmentShow.render $.proxy(((v) -> @$el.html(v.el)), @), id
    showDiagnostic: (id) -> @diagnosticIndex.render $.proxy(((v) -> @$el.html(v.el)), @), id
)