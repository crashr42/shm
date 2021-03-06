define([
  'jquery',
  'backbone',
  'text!templates/appointment_list.html',
  'text!templates/appointment_list_row_all.html',
  'routers/router'
], ($, Backbone, AppointmentListTemplate, AppointmentListRowTemplate,  Router) ->
  Backbone.View.extend

    initialize: ->
      @_list = _.template(AppointmentListTemplate)
      @_row = _.template(AppointmentListRowTemplate)

    events:
      'click .show-appointment': 'show_appointment'

    show_appointment: (e) ->
      e.preventDefault()
      target = $(e.currentTarget)
      Router.instance().navigate(target.attr('href'), true)

#    start_appointment: (e) ->
#      e.preventDefault()
#      element = $(e.currentTarget)
#      $.get "appointment/start_appointment/#{element.attr('id')}", (response) ->
#        alert(response)
#        location.reload()


    render: (callback, id) ->
      document.patient_id = id
      $.get '/cabinet/doctor/appointments', $.proxy((response) ->
        @$el.html response
        callback(@)
      , @)
#      $.getJSON '/cabinet/doctor/appointments', $.proxy((response) ->
#
#        #Create table doctors list
#        @$el.html(@_list())
#
#        #Function status_to_css
#        status_to_css = (status) ->
#          completeCss = ''
#          switch status
#            when 'free' then completeCss = 'label label-success'
#            when 'busy' then completeCss = 'label label-important'
#            when 'process' then completeCss = 'label label-info'
#            when 'close' then completeCss = 'label'
#
#        #Rendering appointment list
#        row_render = (el, row) ->
#          el.find('#appointment-list').append row(a: appointment, cssStatus: status_to_css(appointment.status)) for appointment in response
#        row_render(@$el, @_row)
#        callback(@)
#      , @)
)
