Classes = exports ? this
$ = jQuery

class Classes.EventRenderer
  render: (@event) ->
    @body = $('<div></div>')
    elements =
      summary:
        renderer: new TextRenderer()
        text: 'Summary'
      description:
        renderer: new TextRenderer()
        text: 'Description'
      date_start:
        renderer: new TextRenderer()
        text: 'DateStart'
      date_end:
        renderer: new TextRenderer()
        text: 'DateEnd'
      time_start:
        renderer: new TextRenderer()
        text: 'TimeStart'
      time_end:
        renderer: new TextRenderer()
        text: 'TimeEnd'
    @_renderElements(elements)

    return @body

  _renderElements: (elements) ->
    for name, element of elements
      $(@body).append element.renderer.render @event['get' + element.text](), element.text
      $(element.renderer.element).change {event: @event}, (event) ->
        value = $(@).val()
        try
          event.data.event['set' + element.text](value)
        catch e
          alert e.message

  _groupping: (label, controls...)->
    group = $('<div class="control-group"></div>').append(label)
    controlsGroup = $('<div class="controls"></div>')
    controlsGroup.append control for control in controls
    group.append controlsGroup
    return group