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
      if $(element).attr('data-value') >= @min && $(element).attr('data-value') <= @max
        @elements.push $(element).attr('data-value')
        $(@elementsContainer).append element
        @show @elementsContainer
      else
        alert "Element must be from " + @min + " to " + @max
    else
      alert "Element already exists"

  removeElement: (element) ->
    if @checkExits element
      # TODO: косяк с удалением
      delete @elements[@elements.indexOf($(element).attr('data-value'))]
      $(element).remove()
    @hide @elementsContainer if $(@elementsContainer).children().length == 0

  checkExits: (element) ->
    @elements.indexOf($(element).attr('data-value')) != -1

  addButtonClick: (event) ->
    obj = event.data.obj
    value = $(obj.enterValue).val()
    element = $(obj.element).
    clone().
    text(value).
    attr('data-value', value).
    click({obj: obj}, obj.elementClick)
    obj.addElement element

  elementClick: (event) ->
    event.data.obj.removeElement @

  getData: ->
    @elements.join(',')

class Classes.BySecond extends ByNumber
  constructor: ->
    super 1, 59, 'seconds'

class Classes.ByMinute extends ByNumber
  constructor: ->
    super 1, 59, 'minutes'

class Classes.ByHour extends ByNumber
  constructor: ->
    super 1, 23, 'hours'

class Classes.ByMonthDay extends ByNumber
  constructor: ->
    super 1, 31, 'years'

class Classes.ByYearDay extends ByNumber
  constructor: ->
    super 1, 366, 'days'

class Classes.ByWeekNumber extends ByNumber
  constructor: ->
    super 1, 53, 'weeks'

class Classes.ByPosition extends ByNumber
  constructor: ->
    super 1, 366, 'positions'

