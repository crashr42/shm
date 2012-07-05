Classes = exports ? this
$ = jQuery

class Classes.RuleRenderer
  render: (@rule) ->
    @body = $('<div></div>')
    @_renderFrequency()
    @_renderInterval()
    @_renderCount()
    @_renderUntil()
    @_renderManager()

    return @body

  _groupping: (label, controls...)->
    group = $('<div class="control-group"></div>').append(label)
    controlsGroup = $('<div class="controls"></div>')
    controlsGroup.append control for control in controls
    group.append controlsGroup
    return group

  _renderManager: ->
    managerRenderer = new ByManagerRenderer()
    $(@body).append(managerRenderer.render @rule.getByManager())

  _renderFrequency: ->
    selectRenderer = new SelectRenderer()
    $(@body).append selectRenderer.render {secondly: 'Secondly', minutely:'Minutely'}, 'Frequency'
    $(selectRenderer.select).change({rule: @rule}, @_bindFrequency)

  _bindFrequency: (event) ->
    value = $(@).val()
    try
      event.data.rule.setFrequency(value)
    catch e
      alert e.message

  _renderInterval: ->
    textRenderer = new TextRenderer()
    $(@body).append textRenderer.render @rule.getInterval(), 'Interval'
    $(textRenderer.element).change({rule: @rule}, @_bindInterval)

  _bindInterval: (event) ->
    value = $(@).val()
    try
      event.data.rule.setInterval(value)
    catch e
      alert e.message

  _renderCount: ->
    textRenderer = new TextRenderer()
    $(@body).append textRenderer.render @rule.getCount(), 'Count'
    $(textRenderer.element).change({rule: @rule}, @_bindCount)

  _bindCount: (event) ->
    value = $(@).val()
    try
      event.data.rule.setCount(value)
    catch e
      alert e.message

  _renderUntil: ->
    textRenderer = new TextRenderer()
    $(@body).append textRenderer.render @rule.getUntil(), 'Until'
    $(textRenderer.element).change({rule: @rule}, @_bindUntil)

  _bindUntil: (event) ->
    value = $(@).val()
    try
      event.data.rule.setUntil(value)
    catch e
      alert e.message