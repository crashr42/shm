Classes = exports ? this
$ = jQuery

class Classes.ByNumber
  constructor: (@min, @max, @title) ->
    @elements = []
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
    $(@body).append(@elementsContainer, @enterValue, @addButton)

  addElement: (element) ->
    unless @checkExits element
      if $(element).val() >= @min && $(element).val() <= @max
        @elements.push $(element).val()
        $(@elementsContainer).append element
        @show @elementsContainer
      else
        alert "Element must be from " + @min + " to " + @max
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

  getData: ->
    @elements

class Classes.BySecond extends ByNumber
  constructor: (@key = 'seconds') ->
    super 1, 59, 'seconds'

class Classes.ByMinute extends ByNumber
  constructor: (@key = 'minutes') ->
    super 1, 59, 'minutes'

class Classes.ByHour extends ByNumber
  constructor: ->
    super 1, 23, 'hours'

class Classes.ByMonthDay extends ByNumber
  constructor: (@key = 'years') ->
    super 1, 31, 'years'

class Classes.ByYearDay extends ByNumber
  constructor: (@key = 'days') ->
    super 1, 366, 'days'

class Classes.ByWeekNumber extends ByNumber
  constructor: (@key = 'weeks') ->
    super 1, 53, 'weeks'

class Classes.ByPosition extends ByNumber
  constructor: (@key = 'positions') ->
    super 1, 366, 'positions'

