define([
  'jquery',
  'backbone',
  'wsclient',
  'routers/router',
  'fullcalendar',
  'bootstrap'
], ($, Backbone, Client, Router) ->
  Backbone.View.extend
    render: (callback) ->
      Client.userOn('attendee.create', (data) -> console.log(data))

      $.get('/cabinet/patient/calendar', $.proxy((response) ->
        @$el.html(response)
        callback(@)
        @bindCalendar()
      , @))

    setMenuLink: (link) -> $('a[data-view=calendar]').attr('href', link)

    showEventInfo: (id) ->
      link = '/cabinet/patient/calendar/' + id
      Router.instance().navigate(link, false)
      @setMenuLink(link)
      $.get '/cabinet/patient/event/show/' + id, $.proxy (request) ->
        calendar = @$el.find('#calendar')
        calendar.parent().removeClass('span12').addClass('span8')
        event_info = @$el.find('#event-info')
        event_info.parent().addClass('span4').removeClass('hide')
        event_info.html(request)
        calendar.fullCalendar('option', 'height', calendar.parent().width());
      , @

    bindCalendar: ->
      that = @
      @$el.find('#calendar').fullCalendar
        firstDay: 1
        eventSources: [
          {
          url: '/cabinet/patient/event.json'
          type: 'get'
          error: -> alert 'there was an error while fetching events!'
          }
        ]
        eventDrop: (event, delta) -> that.$el.find('#calendar').fullCalendar('updateEvent', event)
        eventClick: (event, element) -> that.showEventInfo(event.id)
        monthNames: ['Январь','Февраль','Март','Апрель','Май','οюнь','οюль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь']
        monthNamesShort: ['Янв.','Фев.','Март','Апр.','Май','οюнь','οюль','Авг.','Сент.','Окт.','Ноя.','Дек.']
        dayNames: ["Воскресенье","Понедельник","Вторник","Среда","Четверг","Пятница","Суббота"]
        dayNamesShort: ["ВС","ПН","ВТ","СР","ЧТ","ПТ","СБ"]
        buttonText:
          prev: "&nbsp;&#9668;&nbsp;"
          next: "&nbsp;&#9658;&nbsp;"
          prevYear: "&nbsp;&lt;&lt;&nbsp;"
          nextYear: "&nbsp;&gt;&gt;&nbsp;"
          today: "Сегодня"
          month: "Месяц"
          week: "Неделя"
          day: "День"
      $('')
)