Classes = exports ? this
$ = jQuery

class Classes.Until extends Element
  constructor: (@mode, @until_value = "", @key = 'until') ->
    @createBody()
    @setMode(@mode)

  createBody: ->
    @body = $('<div></div>')
    @label = $('<label>Until</label>')
    @hiddenUntilValue = $('<input type="hidden">').val(@until_value)
    @hiddenUntilType = $('<input type="hidden">').val(@mode)
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
    @helpBlock = $('<p class="help-block"></p>')
    @elementGroup = @groupping(
      null,
      @elementEndDate,
      @elementCount,
      @helpBlock
    )
    @body.append(
      @groupping(
        @label,
        @radioGroup.append(
          @radioNoEndDate,
          @radioEndDate,
          @radioCount
        ),
        @hiddenUntilValue,
        @hiddenUntilType
      ),
      @elementGroup
    )
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
    $(obj.helpBlock).text('')

  endDateClick: (event)->
    obj = event.data.obj
    obj.hide obj.elementCount
    obj.show obj.elementEndDate
    obj.show obj.elementGroup
    obj.setValue $(obj.elementEndDate).val()
    obj.setType 'date'
    $(obj.helpBlock).text('Please select date when recurrence rule must be active.')

  countClick: (event)->
    obj = event.data.obj
    obj.hide obj.elementEndDate
    obj.show obj.elementCount
    obj.show obj.elementGroup
    obj.setValue $(obj.elementCount).val()
    obj.setType 'count'
    $(obj.helpBlock).text('Please enter the number of times when recurrence rule must be active.')

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
    {'type': @getType(), 'value': @getValue()}