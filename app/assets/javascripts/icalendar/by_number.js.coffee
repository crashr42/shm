Classes = exports ? this
$ = jQuery

class Classes.ByNumber
  constructor: (@numbers, @title) ->
    @elements = @elements ? []
    @excludeFrequencies = @excludeFrequencies ? []
    @createBody()

  hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  show: (element) ->
    $(element).addClass('active').removeClass('hide')

  createBody: ->
    @body = $('<div></div>')
    @addButton =
      $('<button class="btn btn-success">Add value</button>').
      click({obj: @}, @addButtonClick)
    @elementsContainer = $('<div class="well-small"></div>')
    @hide @elementsContainer
    @element =
      $('<button class="btn btn-primary"></button>')
    @enterValue = $('<input type="text">')
    @helpBlock = $('<p class="help-block"></p>').text(@helpMessage)
    $(@body).append(@elementsContainer, @enterValue, @addButton, @helpBlock)

  addElement: (element) ->
    unless @checkExits element
      if @numbers.indexOf(parseInt($(element).val())) >= 0
        @elements.push $(element).val()
        $(@elementsContainer).append element
        @show @elementsContainer
      else
        alert @validationMessage
    else
      alert "Element already exists"

  removeElement: (element) ->
    if @checkExits element
      @elements.splice(@elements.indexOf($(element).val()), 1)
      $(element).remove()
    @hide @elementsContainer if @elements.length == 0

  checkExits: (element) ->
    @elements.indexOf($(element).val()) != -1

  addButtonClick: (event) ->
    obj = event.data.obj
    value = $(obj.enterValue).val()
    element = $(obj.element).
    clone().
    text(value).
    val(value).
    click({obj: obj}, obj.elementClick)
    obj.addElement element

  elementClick: (event) ->
    event.data.obj.removeElement @

  serialize: ->
    @elements

class Classes.BySecond extends ByNumber
  constructor: (@key = 'seconds') ->
    @validationMessage = 'Seconds must be from 1 to 59 include.'
    @helpMessage = @validationMessage
    super [1...60], 'seconds'

class Classes.ByMinute extends ByNumber
  constructor: (@key = 'minutes') ->
    @validationMessage = 'Minutes must be from 1 to 59 include.'
    @helpMessage = @validationMessage
    super [1...60], 'minutes'

class Classes.ByHour extends ByNumber
  constructor: ->
    @validationMessage = 'Hours must be from 1 to 23 include.'
    @helpMessage = @validationMessage
    super [1...24], 'hours'

class Classes.ByMonthDay extends ByNumber
  constructor: (@key = 'month_days') ->
    @validationMessage = 'Month days must be from -31 to 31 include, exclude 0.'
    @helpMessage = @validationMessage
    @excludeFrequencies = ['WEEKLY']
    super [-31...0].concat([1...32]), 'month_days'

class Classes.ByYearDay extends ByNumber
  constructor: (@key = 'days') ->
    @excludeFrequencies = ['DAILY', 'WEEKLY', 'MONTHLY']
    @validationMessage = 'Year days must be from -366 to 366 include, exclude 0.'
    @helpMessage = @validationMessage
    super [-366...0].concat([1...367]), 'days'

class Classes.ByWeekNumber extends ByNumber
  constructor: (@key = 'weeks') ->
    @excludeFrequencies = ['SECONDLY', 'MINUTELY', 'HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY']
    @validationMessage = 'Seconds must be from 1 to 53 include.'
    @helpMessage = @validationMessage
    super [1...54], 'weeks'

class Classes.ByPosition extends ByNumber
  constructor: (@key = 'positions') ->
    @validationMessage = 'Seconds must be from 1 to 366 include.'
    @helpMessage = @validationMessage
    super [1...367], 'positions'

