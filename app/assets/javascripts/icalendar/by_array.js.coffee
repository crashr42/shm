Classes = exports ? this
$ = jQuery

class Classes.ByArray
  constructor: (@data, @title) ->
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
    @elementsSelector = $('<select></select>')
    for key, value in @data
      $(@elementsSelector).append($('<option></option>').val(value).text(key))
    $(@body).append(@elementsContainer, @elementsSelector, @addButton)

  addElement: (element) ->
    unless @checkExits element
      @elements.push element
      $(@elementsContainer).append element
      @show @elementsContainer
    else
      alert "Element already exists"

  removeElement: (element) ->
    for i in [0...@elements.length]
      delete @elements[i] if $(@elements[i]).attr('data-value') == $(element).attr('data-value')
    $(element).remove()
    @hide @elementsContainer if $(@elementsContainer).children().length == 0

  checkExits: (element) ->
    for e in @elements
      return true if $(e).attr('data-value') == $(element).attr('data-value')
    return false

  addButtonClick: (event) ->
    obj = event.data.obj
    selectedElement = $(obj.elementsSelector).find(':selected')
    value = selectedElement.val()
    text = selectedElement.text()
    element = $(obj.element).
    clone().
    text(text).
    attr('data-value', value).
    click({obj: obj}, obj.elementClick)
    obj.addElement element

  elementClick: (event) ->
    event.data.obj.removeElement @

class Classes.ByMonth extends ByArray
  constructor: ->
    super [
      "January", "February", "March", "April", "May", "June", "July",
      "August", "September", "October", "November", "December"
    ], 'months'
