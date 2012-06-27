Classes = exports ? this
$ = jQuery

class Classes.ByArray
  constructor: (@data, @title) ->
    @elements = []
    @excludeFrequencies = []
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
    for key, value of @data
      $(@elementsSelector).append($('<option></option>').val(key).text(value))
    @helpBlock = $('<p class="help-block"></p>').text(@helpMessage)
    $(@body).append(@elementsContainer, @elementsSelector, @addButton, @helpBlock)

  addElement: (element) ->
    unless @checkExits element
      @elements.push $(element).val()
      $(@elementsContainer).append element
      $(@elementsSelector).find('option[value=' + $(element).val() + ']').addClass('hide')
      if $(@elementsSelector).find('option:not(.hide)').length != 0
        $(@elementsSelector).find('option:not(.hide):first').attr('selected', 'selected')
      else
        $(@elementsSelector).addClass('hide')
        $(@addButton).addClass('hide')
      @show @elementsContainer
    else
      alert "Element already exists"

  removeElement: (element) ->
    if @checkExits element
      @elements.splice(@elements.indexOf($(element).val()), 1)
      $(@elementsSelector).removeClass('hide')
      $(@addButton).removeClass('hide')
      $(@elementsSelector).find('option[value=' + $(element).val() + ']').removeClass('hide')
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
    months = new Array()
    months[1] = "January"
    months[2] = "February"
    months[3] = "March"
    months[4] = "April"
    months[5] = "May"
    months[6] = "June"
    months[7] = "July"
    months[8] = "August"
    months[9] = "September"
    months[10] = "October"
    months[11] = "November"
    months[12] = "December"
    @validationMessage = "Month number must be from 1 to 12 include."
    @helpMessage = @validationMessage
    super months, 'months'
