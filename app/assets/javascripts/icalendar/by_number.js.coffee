Classes = exports ? this
$ = jQuery

class Classes.ByNumber
  constructor: (@numbers, @key_name) ->
    @numbers = @numbers ? []
    @elements = []
    @excludeFrequencies = @excludeFrequencies ? []

  getValue: (key) ->
    return key if @numbers instanceof Array
    return @numbers[key] if typeof @numbers == 'object' && @numbers.hasOwnProperty key

  allowElement: (key) ->
    (@numbers instanceof Array && @numbers.indexOf(key) >= 0) || (typeof(@numbers) == 'object' && @numbers.hasOwnProperty key)

  addElement: (element) ->
    element = parseInt element
    throw {message: "already_exists"} if @checkExits element
    throw {message: "element_not_alowed"} unless @allowElement element
    @elements.push element

  removeElement: (element) ->
    element = parseInt(element) if @elements instanceof Array
    @elements.splice(@elements.indexOf(element), 1) if @checkExits element

  checkExits: (element) ->
    @elements.indexOf(element) >= 0

  serialize: ->
    data = {}
    eval('data.' + @key_name + '=this.elements')
    return data

  deserialize: (data) ->
    @datas = data[@key_name] ? []
    for d in @datas
      @addElement d
    return @

class Classes.ByNumberRenderer
  render: (@data) ->
    unless @data instanceof ByNumber
      throw
        message: 'instance_type_not_alowed'

    @_createBody()
    @_renderElements()

    return @body

  _hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  _show: (element) ->
    $(element).addClass('active').removeClass('hide')

  _createBody: ->
    @body = $('<div></div>')
    @addButton =$('<button class="btn btn-success">Add value</button>').click({obj: @}, @_addButtonClick)
    @elementsContainer = $('<div class="well-small"></div>')
    @_hide @elementsContainer
    @element = $('<button class="btn btn-primary"></button>')
    @enterValue = $('<input type="text">')
    @helpBlock = $('<p class="help-block"></p>').text(@helpMessage)
    $(@body).append(@elementsContainer, @enterValue, @addButton, @helpBlock)

  _renderElements: ->
    for element in @data.elements
      $(@elementsContainer).append(@_createElement(element))

  _createElement: (element) ->
    $(@element).clone().text(element).val(element).click({obj: @}, @_elementClick)

  _addElement: (element) ->
    value = $(@enterValue).val()
    try
      @data.addElement value
      @_createElement value
      @_show @elementsContainer
      $(@enterValue).removeClass('error')
    catch e
      $(@enterValue).addClass('error')

  _removeElement: (element) ->
    @data.removeElement $(element).val()
    $(element).remove()
    @_hide @elementsContainer if @data.elements.length == 0

  _addButtonClick: (event) ->
    event.data.obj._addElement @

  _elementClick: (event) ->
    event.data.obj._removeElement @

class Classes.BySecond extends ByNumber
  constructor: (@key = 'seconds') ->
    super [1...60], 'seconds'

class Classes.ByMinute extends ByNumber
  constructor: (@key = 'minutes') ->
    super [1...60], 'minutes'

class Classes.ByHour extends ByNumber
  constructor: (@key = 'hours') ->
    super [1...24], 'hours'

class Classes.ByMonthDay extends ByNumber
  constructor: (@key = 'month_days') ->
    @excludeFrequencies = ['WEEKLY']
    super [-31...0].concat([1...32]), 'month_days'

class Classes.ByYearDay extends ByNumber
  constructor: (@key = 'year_days') ->
    @excludeFrequencies = ['DAILY', 'WEEKLY', 'MONTHLY']
    super [-366...0].concat([1...367]), 'year_days'

class Classes.ByWeekNumber extends ByNumber
  constructor: (@key = 'weeks') ->
    @excludeFrequencies = ['SECONDLY', 'MINUTELY', 'HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY']
    super [1...54], 'weeks'

class Classes.ByPosition extends ByNumber
  constructor: (@key = 'positions') ->
    super [1...367], 'positions'

class Classes.ByMonth extends ByNumber
  constructor: (@key = 'months') ->
    months =
      1:  "January"
      2:  "February"
      3:  "March"
      4:  "April"
      5:  "May"
      6:  "June"
      7:  "July"
      8:  "August"
      9:  "September"
      10: "October"
      11: "November"
      12: "December"
    super months, 'months'
