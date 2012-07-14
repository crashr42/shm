Classes = exports ? this
$ = jQuery

class Classes.EventRenderer
  render: (event) ->
    that = @
    elements =
      body: $('<div></div>')
      summary:
        body: $('<div class="control-group"></div>')
        label: $('<label class="control-label">Summary</label>')
        controls:
          body: $('<div class="controls"></div>')
          input:
            body: $('<input type="text" placeholder="summary">')
            events:
              change: -> event.setSummary($(@).val())
      description:
        body: $('<div class="control-group"></div>')
        label: $('<label class="control-label">Description</label>')
        controls:
          body: $('<div class="controls"></div>')
          input:
            body: $('<input type="text" placeholder="description">')
            events:
              change: -> event.setDescription($(@).val())
      date_start:
        body: $('<div class="control-group"></div>')
        label: $('<label class="control-label">Date start</label>')
        controls:
          body: $('<div class="controls"></div>')
          date:
            body: $('<input type="text" placeholder="date start">').datepicker()
            events:
              change: -> event.setDateStart($(@).val())
          time:
            body: $('<input type="text" placeholder="time start">').timepicker()
            events:
              change: -> event.setTimeStart($(@).val())
      date_end:
        body: $('<div class="control-group"></div>')
        label: $('<label class="control-label">Date end</label>')
        controls:
          body: $('<div class="controls"></div>')
          date:
            body: $('<input type="text" placeholder="date end">').datepicker()
            events:
              change: -> event.setDateEnd($(@).val())
          time:
            body: $('<input type="text" placeholder="time end">').timepicker()
            events:
              change: -> event.setTimeEnd($(@).val())
      controls_group:
        body: $('<div class="btn-group" data-toggle="buttons-checkbox"></div>')
        whole_day:
          body: $('<button class="btn btn-primary">Whole day?</button>')
          events:
            click: ->
              unless $(@).hasClass('active')
                elements.date_start.controls.time.body.hide()
                elements.date_end.controls.time.body.hide()
              else
                elements.date_start.controls.time.body.show()
                elements.date_end.controls.time.body.show()
      add_recurrency:
        body: $('<button class="btn btn-primary">Add rule</button>')
        events:
          click: ->
            rule = new Classes.Rule()
            event.addRule(rule)
            renderer = new Classes.RuleRenderer()
            element =
              body: $('<div class="alert alert-info"></div>')
              close:
                body: $('<button class="close" data-dismiss="alert">x</button>')
              name: $('<h3>Rule</h3>')
              rule: renderer.render(rule)
            elements.recurrency.body.append(that._renderDom(element))
      recurrency:
        body: $('<div></div>')

    return @_renderDom(elements)

  _renderDom: (dom) ->
    body = @_findBody(dom)
    @_bindEvents(dom, body)
    for n, p of dom when ['events', 'body', 'properties', 'methods'].indexOf(n) < 0
      body.append(@_renderDom(p)) unless p instanceof $ || p instanceof Array
      body.append(@_renderDom(e)) for e in p if p instanceof Array
      body.append(p) if p instanceof $
    return body

  _findBody: (dom) ->
    throw {message: 'not_found_element_body'} unless dom.hasOwnProperty('body')
    return dom.body

  _bindEvents: (dom, element) ->
    element.bind(n, e) for n, e of dom.events if dom.hasOwnProperty('events')