define([
  'jquery',
  'backbone',
  'views/appointment',
  'views/index',
  'views/parameter',
  'views/calendar',
  'views/doctor',
  'views/history',
  'binder'
], (
  $,
  Backbone,
  Appointment,
  Index,
  Parameter,
  Calendar,
  Doctor,
  History,
  Binder
) ->
  Backbone.View.extend
    initialize: ->
      @appointment = new Appointment(parentView: @)
      @index = new Index(parentView: @)
      @parameter = new Parameter(parentView: @)
      @calendar = new Calendar(parentView: @)
      @doctor = new Doctor(parentView: @)
      @history = new History(parentView: @)

    hideAll: ->
      @$el.children('div').hide()

    showIndex: ->
      @hideAll()
      if @index_cache
        @index_cache.$el.show()
        Binder.setNewContentHeight()
      else
        @index.render $.proxy (v) ->
          @index_cache = v
          @$el.append @index_cache.el
          Binder.setNewContentHeight()
        , @

    showAppointment: ->
      @hideAll()
      if @appointment_cache
        @appointment_cache.$el.show()
        Binder.setNewContentHeight()
      else
        @appointment.render $.proxy (v) ->
          @appointment_cache = v
          @$el.append @appointment_cache.el
          Binder.setNewContentHeight()
        , @

    showParameter: ->
      @hideAll()
      if @parameter_cache
        @parameter_cache.$el.show()
        Binder.setNewContentHeight()
      else
        @parameter.render $.proxy (v) ->
          @parameter_cache = v
          @$el.append @parameter_cache.el
          Binder.setNewContentHeight()
        , @

    showCalendar: ->
      @hideAll()
      if @calendar_cache
        @calendar_cache.$el.show()
        Binder.setNewContentHeight()
      else
        @calendar.render $.proxy (v) ->
          @calendar_cache = v
          @$el.append @calendar_cache.el
          Binder.setNewContentHeight()
        , @

    showDoctor: ->
      @doctor.render $.proxy (v) ->
        @$el.html v.el
      , @

    showHistory: (cb) ->
      @hideAll()
      if @history_cache
        @history_cache.$el.show()
        Binder.setNewContentHeight()
        cb.call @, @history_cache
      else
        @history.render $.proxy (v) ->
          @history_cache = v
          @$el.append @history_cache.el
          Binder.setNewContentHeight()
          cb.call @, @history_cache
        , @
)