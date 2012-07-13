Classes = exports ? this
$ = jQuery

$(document).ready ->
  tabs =
    [
      {
      name: 'Day'
      h:
        date_start: new Date(2012, 7, 11, 0, 0, 0, 0)
        date_end: new Date(2012, 7, 12, 0, 0, 0, 0)
        stepper: (date) -> date.setDate(date.getDate() + 1)
        formatter: (date) -> date.toLocaleDateString()
      v:
        date_start: new Date(2012, 7, 11, 0, 0, 0, 0)
        date_end: new Date(2012, 7, 12, 0, 0, 0, 0)
        stepper: (date) -> date.setMinutes(date.getMinutes() + 20)
        formatter: (date) -> date.toLocaleTimeString()
      },
      {
      name: '4 Days'
      h:
        date_start: new Date(2012, 7, 11, 0, 0, 0, 0)
        date_end: new Date(2012, 7, 15, 0, 0, 0, 0)
        stepper: (date) -> date.setDate(date.getDate() + 1)
        formatter: (date) -> date.toLocaleDateString()
      v:
        date_start: new Date(2012, 7, 11, 0, 0, 0, 0)
        date_end: new Date(2012, 7, 12, 0, 0, 0, 0)
        stepper: (date) -> date.setMinutes(date.getMinutes() + 20)
        formatter: (date) -> date.toLocaleTimeString()
      }
    ]
  r = new CalendarRenderer()
  $('#irrule').append(r.render(tabs))

class Classes.CalendarRenderer
  elements = {}

  constructor: ->
    elements =
      body: $('<div></div>')
      calendar:
        body: $('<div></div>')
        menu:
          body: $('<div class="well"></div>')
          title:
            body: $('<h1>Calendar</h1>')
          events_menu:
            body: $('<div class="btn-group"></div>')
            new:
              body: $('<button class="btn btn-success">New event</button>')
              events:
                click: -> elements.editor.methods.new_event()
      editor:
        body: $('<div class="hide"></div>')
        menu:
          body: $('<div class="well"></div>')
          title:
            body: $('<h1>Event</h1>')
          buttons:
            body: $('<div class="btn-group"></div>')
            back:
              body: $('<button class="btn btn-primary">Back</button>')
              events:
                click: ->
                  elements.editor.body.hide()
                  elements.calendar.body.show()
        content:
          body: $('<div></div>')
        methods:
          show: (hdate, vdate) ->
            elements.editor.body.show()
            elements.calendar.body.hide()
          new_event: ->
            e = new Classes.Event()
            r = new Classes.EventRenderer()
            elements.editor.content.body.html(r.render e)
            elements.editor.methods.show(0, 0)

  render: (tabs) ->
    elements.calendar.tabs = []
    elements.calendar.menu.buttons =
      body: $('<div class="btn-group" data-toggle="buttons-radio"></div>')
    for tab in tabs
      do ->
        t =
          body: $('<div></div>').hide()
          table:
            body: $('<table class="table table-bordered table-striped"></table>')
            tr: []
        button =
          body: $('<button class="btn btn-primary"></button>').text(tab.name)
          events:
            click: ->
              unless button.body.hasClass('active')
                tt.body.hide() for tt in elements.calendar.tabs
                t.body.show()
        elements.calendar.menu.buttons[tab.name] = button
        row_head = true
        column_head = true
        back_v_date_start = new Date(tab.v.date_start.getTime())
        while back_v_date_start < tab.v.date_end
          do ->
            back_h_date_start = new Date(tab.h.date_start.getTime())
            tr =
              body: $('<tr></tr>')
              td: []
            while back_h_date_start < tab.h.date_end
              do ->
                td =
                  properties:
                    hdate: new Date(back_h_date_start.getTime())
                    vdate: new Date(back_v_date_start.getTime())
                  events:
                    click: -> elements.editor.methods.show td.properties.hdate, td.properties.vdate
                td.body = $('<td></td>') if (column_head && row_head) || (!column_head && !row_head)
                td.body = $('<td></td>').text(tab.h.formatter(back_h_date_start)) if column_head && !row_head
                td.body = $('<td></td>').text(tab.v.formatter(back_v_date_start)) if !column_head && row_head
                tr.td.push td
                tab.h.stepper(back_h_date_start) unless row_head
                row_head = false if row_head
            tab.v.stepper(back_v_date_start) unless column_head
            t.table.tr.push tr
            column_head = false
            row_head = true
        elements.calendar.tabs.push t
    @_renderDom(elements)

  body: -> elements.body

  _renderDom: (dom) ->
    body = @_findBody(dom)
    @_bindEvents(dom, body)
    for n, p of dom when ['events', 'body', 'properties', 'methods'].indexOf(n) < 0
      body.append(@_renderDom(p)) unless p instanceof $ || p instanceof Array
      body.append(@_renderDom(e)) for e in p if p instanceof Array
    return body

  _findBody: (dom) ->
    throw {message: 'not_found_element_body'} unless dom.hasOwnProperty('body')
    return dom.body

  _bindEvents: (dom, element) ->
    element.bind(n, e) for n, e of dom.events if dom.hasOwnProperty('events')

