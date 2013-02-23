define([
  'jquery',
  'backbone',
  'highcharts',
  'underscore',
  'text!templates/history.html',
  'routers/router'
], ($, Backbone, Highcharts, _, Body, Router) ->
  Backbone.View.extend
    initialize: ->
      @offset = 0
      @limit = 10

    events:
      'click .documents a': 'showDocumentInfoEvent'

    showDocumentInfoEvent: (e) ->
      e.preventDefault()
      id = $(e.currentTarget).attr('data-id')
      @showDocumentInfo(id)

    showDocumentInfo: (id) ->
      Router.instance().navigate("/cabinet/patient/event/history/#{@event_id}/#{id}", false)
      $.post "/cabinet/patient/document/show/#{id}", $.proxy (response) ->
        @$el.find('.info').html(response)
      , @

    moveTimeline: ->
      $.post('/cabinet/patient/event/history.json', {offset: @offset, limit: @limit}, $.proxy((response) ->
        @chart.series[0].setData(response)
      , @))

    showEventInfo: (id) ->
      @event_id = id
      Router.instance().navigate("/cabinet/patient/event/history/#{id}", false)
      $.get "/cabinet/patient/event/show/#{id}", $.proxy (response) ->
        @$el.find('.event-info').html(response)
        @$el.find('.info').html('')
      , @

    render: (callback) ->
      $.post('/cabinet/patient/event/history.json', {offset: @offset, limit: @limit}, $.proxy((response) ->
        @$el.html(_.template(Body)())
        callback(@)
        @delegateEvents()
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
                click: -> view.showEventInfo(this.id)
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