define([
  'jquery',
  'backbone'
], ($, Backbone) ->
  Backbone.View.extend
    events:
      'click .parameter': 'showParameterDiagnostic'

    showParameterDiagnostic: (e) ->
      id = $(e.currentTarget).attr('data-id')
      data =
        patient_id: @patient_id
        parameter_id: id
        from: +new Date(2013, 0, 1, 0, 0, 0, 0) / 1000
        to: +new Date(2013, 11, 31, 23, 59, 59, 0) / 1000
      $.post('/cabinet/doctor/diagnostic/data', data, $.proxy((response) ->
        @renderChart(response)
      , @))

    render: (callback, id) ->
      @patient_id = id

      $.get("/cabinet/doctor/diagnostic/show/#{id}", $.proxy((response) ->
        @$el.html(response)
        @delegateEvents()
        callback(@)
      , @))

    renderChart: (data) ->
      new Highcharts.Chart(
        chart:
          renderTo: 'chart'
        title:
          text: 'Daily visits at www.highcharts.com'
        subtitle:
          text: 'Source: Google Analytics'
        xAxis:
          type: 'datetime'
          tickInterval: 7 * 24 * 3600 * 1000
          tickWidth: 0
          gridLineWidth: 1
          labels:
            align: 'left'
            x: 3
            y: -3

        series: [
          {
          name: 'Temperature'
          data: data
          lineWidth: 4
          marker:
            radius: 4
          }
        ]
      )
)