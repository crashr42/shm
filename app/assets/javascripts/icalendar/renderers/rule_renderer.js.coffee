Classes = exports ? this
$ = jQuery

class Classes.RuleRenderer
  render: (@rule) ->
    d = @
    @rule.onDeserialize = (o) ->
      d.render o

    @body = $(@body ? $('<div></div>')).html('')
    elements =
      interval:
        renderer: new TextRenderer()
        text: 'Interval'
      count:
        renderer: new TextRenderer()
        text: 'Count'
      until:
        renderer: new TextRenderer()
        text: 'Until'
    @managerRenderer = new ByManagerRenderer()
    @_renderFrequency()
    @_renderElements(elements)
    @_renderManager()

    return @body

  _renderElements: (elements) ->
    for name, element of elements
      $(@body).append element.renderer.render @rule['get' + element.text](), element.text
      $(element.renderer.element).change {rule: @rule}, (event) ->
        value = $(@).val()
        try
          event.data.rule['set' + element.text](value)
        catch e
          alert e.message

  _groupping: (label, controls...)->
    group = $('<div class="control-group"></div>').append(label)
    controlsGroup = $('<div class="controls"></div>')
    controlsGroup.append control for control in controls
    group.append controlsGroup
    return group

  _renderManager: ->
    $(@body).append(@managerRenderer.render @rule.getByManager())

  _renderFrequency: ->
    selectRenderer = new SelectRenderer()
    $(@body).append selectRenderer.render ["SECONDLY", "MINUTELY", "HOURLY", "DAILY", "WEEKLY", "MONTHLY", "YEARLY"], 'Frequency'
    $(selectRenderer.element).change({mr: @managerRenderer}, @_bindFrequency)

  _bindFrequency: (event) ->
    value = $(@).val()
    try
      event.data.mr.setFrequency(value)
    catch e
      alert e.message