Classes = exports ? this
$ = jQuery

class Classes.Until extends Element
  constructor: (@mode, @until_value = "") ->
    @createBody()
    @setMode(@mode)

  createBody: ->
    @body = $('<div></div>')
    @label = $('<label class="control-label">Until</label>')
    @hiddenUntilValue = $('<input type="hidden" name="until_value">').val(@until_value)
    ;
    @hiddenUntilType = $('<input type="hidden" name="until_type">').val(@mode)
    ;
    @radioGroup = $('<div class="btn-group" data-toggle="buttons-radio"></div>')
    @radioNoEndDate =
      $('<button class="btn" data-type="no">no end date</button>').click({obj: @}, @noEndDateClick)
    @radioEndDate =
      $('<button class="btn" data-type="date">end date</button>').click({obj: @}, @endDateClick)
    @radioCount =
      $('<button class="btn" data-type="count">count</button>').click({obj: @}, @countClick)
    @elementEndDate =
      $('<input type="text" placeholder="date"/>').
      keyup({obj: @}, @elementEndDateKeyUp)
    @elementCount =
      $('<input type="text" placeholder="count"/>').
      keyup({obj: @}, @elementCountKeyUp)
    @elementGroup = @groupping(
      null,
      @elementEndDate,
      @elementCount
    )
    @body.append(@groupping(
      @label,
      @radioGroup.
      append(@radioNoEndDate).
      append(@radioEndDate).
      append(@radioCount),
      @hiddenUntilValue,
      @hiddenUntilType
    )).append(@elementGroup)
    return @body

  setMode: (@mode) ->
    $(@body).
    find('button[data-type="' + @mode + '"]').
    button('toggle').
    click()

  setType: (@mode) ->
    $(@hiddenUntilType).val(@mode)

  setValue: (@value) ->
    $(@hiddenUntilValue).val(@value)

  getType: ->
    $(@hiddenUntilType).val()

  getValue: ->
    $(@hiddenUntilValue).val()

  noEndDateClick: (event)->
    obj = event.data.obj
    obj.hide obj.elementCount
    obj.hide obj.elementEndDate
    obj.hide obj.elementGroup
    obj.setValue null
    obj.setType 'no'

  endDateClick: (event)->
    obj = event.data.obj
    obj.hide obj.elementCount
    obj.show obj.elementEndDate
    obj.show obj.elementGroup
    obj.setValue $(obj.elementEndDate).val()
    obj.setType 'date'

  countClick: (event)->
    obj = event.data.obj
    obj.hide obj.elementEndDate
    obj.show obj.elementCount
    obj.show obj.elementGroup
    obj.setValue $(obj.elementCount).val()
    obj.setType 'count'

  elementEndDateKeyUp: (event)->
    obj = event.data.obj
    value = $(@).val()
    obj.setValue(value)
    value

  elementCountKeyUp: (event)->
    obj = event.data.obj
    value = $(@).val()
    obj.setValue(value)
    value

  getData: ->
    {'until': {
      'type': @getType(),
      'value': @getValue()
    }}