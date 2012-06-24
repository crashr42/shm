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
      @elements.push $(element).val()
      $(@elementsContainer).append element
      @show @elementsContainer
    else
      alert "Element already exists"

  removeElement: (element) ->
    if @checkExits element
      @elements.splice(@elements.indexOf($(element).val()), 1)
      $(element).remove()
    @hide @elementsContainer if @elements.length == 0

  checkExits: (element) ->
    @elements.indexOf($(element).val()) >= 0

  addButtonClick: (event) ->
    obj = event.data.obj
    selectedElement = $(obj.elementsSelector).find(':selected')
    value = selectedElement.val()
    text = selectedElement.text()
    element = $(obj.element).
    clone().
    text(text).
    val(value).
    click({obj: obj}, obj.elementClick)
    obj.addElement element

  elementClick: (event) ->
    event.data.obj.removeElement @

  getData: ->
    @elements

class Classes.ByMonth extends ByArray
  constructor: (@key = 'months') ->
    super [
      "January", "February", "March", "April", "May", "June", "July",
      "August", "September", "October", "November", "December"
    ], 'months'
