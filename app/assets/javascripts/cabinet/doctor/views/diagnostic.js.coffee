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
      'click .toogleData': 'toogleData'

    postData: ->
      from = moment(@$el.find('.start-date').val(), 'DD.MM.YYYY')
      to = moment(@$el.find('.end-date').val(), 'DD.MM.YYYY')

      patient_id: @patient_id
      parameter_id: @selected_parameter_id
      from: from / 1000
      to: to / 1000

    showParameterDiagnostic: (e) ->
      @$el.find('.data').slideUp().html('')
      @$el.find('.toogleData').removeClass('active')
      @selected_parameter_id = $(e.currentTarget).attr('data-id')
      @loadedRawData = false
      $.post('/cabinet/doctor/diagnostic/chart', @postData(), $.proxy((response) ->
        @renderChart(response)
        @$el.find('.toogleData').show()
      , @))

    toogleData: (e) ->
      el = $(e.currentTarget)
      unless @loadedRawData
        el.button('loading')
        $.post("/cabinet/doctor/diagnostic/raw/#{@patient_id}", @postData(), $.proxy((response) ->
          @loadedRawData = true
          @$el.find('.data').html(response)
          el.button('reset')
        , @))
      @$el.find('.data').slideToggle();

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