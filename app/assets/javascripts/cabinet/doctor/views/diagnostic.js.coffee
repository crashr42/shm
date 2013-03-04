define([
  'jquery',
  'backbone',
  'underscore',
  'highstock',
  'bootstrap',
  'moment'
], ($, Backbone, _, Highcharts) ->
  Backbone.View.extend
    events:
      'click .parameter': 'showParameterDiagnostic'

    postData: ->
      from = moment(@$el.find('.start-date').val(), 'DD.MM.YYYY')
      to = moment(@$el.find('.end-date').val(), 'DD.MM.YYYY')

      patient_id: @patient_id
      parameter_id: @selected_parameter_id
      from: from / 1000
      to: to / 1000

    showParameterDiagnostic: (e) ->
      el = $(e.currentTarget)
      el.parent().parent().find('li').removeClass('active')
      el.parent().addClass('active')
      @selected_parameter_id = el.attr('data-id')
      $.post '/cabinet/doctor/diagnostic/chart', @postData(), $.proxy (response) ->
        @renderChart(response)
        $.post '/cabinet/doctor/diagnostic/raw', @postData(), $.proxy (response) ->
          @$el.find('.data').html(response).parent().removeClass('hide')
        , @
      , @

    render: (callback, id) ->
      @patient_id = id
      $.get("/cabinet/doctor/diagnostic/show/#{@patient_id}", $.proxy((response) ->
        @$el.html(response)
        @delegateEvents()
        callback(@)
      , @))

    renderChart: (data) ->
      data.chart.renderTo = @$el.find('.chart')[0]
      if data.hasOwnProperty('xAxis') && data.xAxis.type == 'datetime'
        @chart = new Highcharts.StockChart(data)
      else
        @chart = new Highcharts.Chart(data)
)