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
          buttons:
            body: $('<div class="btn-group"></div>')
            back:
              body: $('<button class="btn btn-primary">Forward</button>')
              events:
                click: ->
                  elements.calendar.body.hide()
                  elements.editor.body.show()
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
    @_renderDom(elements)

  render: (tabs) ->
    dom =
      body: $('<div></div>')
      tabs: []
    for tab in tabs
      t =
        body: $('<div></div>')
        table:
          body: $('<table class="table table-bordered table-striped"></table>')
          tr: []
      row_head = true
      column_head = true
      back_v_date_start = new Date(tab.v.date_start.getTime())
      while back_v_date_start < tab.v.date_end
        back_h_date_start = new Date(tab.h.date_start.getTime())
        tr =
          body: $('<tr></tr>')
          td: []
        while back_h_date_start < tab.h.date_end
          tr.td.push {body: $('<td></td>')} if (column_head && row_head) || (!column_head && !row_head)
          tr.td.push {body: $('<td></td>').text(tab.h.formatter(back_h_date_start))} if column_head && !row_head
          tr.td.push {body: $('<td></td>').text(tab.v.formatter(back_v_date_start))} if !column_head && row_head
          tab.h.stepper(back_h_date_start) unless row_head
          row_head = false if row_head
        tab.v.stepper(back_v_date_start) unless column_head
        t.table.tr.push tr
        column_head = false
        row_head = true
      dom.tabs.push t
      console.log dom
    @_renderDom(dom)

  body: -> elements.body

  _renderDom: (dom) ->
    body = @_findBody(dom)
    @_bindEvents(dom, body)
    for n, p of dom when ['events', 'body'].indexOf(n) < 0
      body.append(@_renderDom(p)) unless p instanceof $ || p instanceof Array
      body.append(@_renderDom(e)) for e in p if p instanceof Array
    return body

  _findBody: (dom) ->
    throw {message: 'not_found_element_body'} unless dom.hasOwnProperty('body')
    return dom.body

  _bindEvents: (dom, element) ->
    element.bind(n, e) for n, e of dom.events if dom.hasOwnProperty('events')

