define([
  'jquery',
  'backbone',
  'highcharts',
  'underscore',
  'text!templates/history.html'
], ($, Backbone, Highcharts, _, Body) ->
  Backbone.View.extend
    initialize: ->
      @offset = 0
      @limit = 10

    events:
      'click .event': 'showEventInfo'
      'click .next-ten': 'nextTen'
      'click .previous-ten': 'previouseTen'

    nextTen: (e) ->
      e.preventDefault()
      @offset -= 10;
      $(e.currentTarget).hide() if @offset == 0
      @moveTimeline()

    previouseTen: (e) ->
      e.preventDefault()
      @offset += 10;
      @$el.find('.next-ten').show()
      @moveTimeline()

    moveTimeline: ->
      $.post('/cabinet/patient/event/history.json', {offset: @offset, limit: @limit}, $.proxy((response) ->
        @chart.series[0].setData(response)
      , @))

    showEventInfo: (e) ->
      @current_event_id = $(e.currentTarget).attr('data-id')
      $.post('/cabinet/patient/event/documents', {id: @current_event_id}, $.proxy((response) ->
        @$el.find('.event-info').html(response)
      , @))

    render: (callback) ->
      $.post('/cabinet/patient/event/history.json', {offset: @offset, limit: @limit}, $.proxy((response) ->
        @$el.html(_.template(Body)())
        @delegateEvents()
        callback(@)
        @renderTimeLine(response)
      , @))

    renderTimeLine: (data) ->
      view = @
      @chart = new Highcharts.Chart(
        chart:
          renderTo: 'chart'
          type: 'line'
          height: 160
        title:
          text: ''
          x: -20 #center
        plotOptions:
          line:
            marker:
              enabled: true
              radius: 8
          series:
            cursor: 'pointer'
            point:
              events:
                click: ->
                  $.get("/cabinet/patient/event/show/#{this.id}", (response) ->
                    view.$el.find('.event-info').html(response)
                  )
        xAxis:
          title:
            text: 'Выберите событие для просмотра информации'
          labels:
            enabled: false
          lineWidth: 0
          tickWidth: 0
        yAxis:
          labels:
            enabled: false
          title:
            text: 'События'
          plotLines: [
            value: 0
            width: 1
            color: '#808080'
          ]
        legend:
          enabled: false
        tooltip:
          enabled: true
          formatter: -> '<b>' + @point.type + '</b><br />' + @point.dateStart + ' - ' + @point.dateEnd
        series: [name: 'События', data: data]
      )
)