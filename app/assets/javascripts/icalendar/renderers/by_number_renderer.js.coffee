Classes = exports ? this
$ = jQuery

class Classes.ByNumberRenderer
  render: (@data) ->
    unless @data instanceof ByNumber
      throw
      message: 'instance_type_not_alowed'

    d = @
    @data.onDeserialize = (object) ->
      d.render object

    @body = (@body ? $('<div></div>')).html('')

    @_createBody()
    @_renderElements()

    return @body

  _hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  _show: (element) ->
    $(element).addClass('active').removeClass('hide')

  _createBody: ->
    @addButton =$('<button class="btn btn-success">Add value</button>').click({obj: @}, @_addButtonClick)
    @elementsContainer = $('<div class="well-small"></div>')
    @_hide @elementsContainer
    @element = $('<button class="btn btn-primary"></button>')
    @enterValue = $('<input type="text">')
    @helpBlock = $('<p class="help-block"></p>').text(@helpMessage)
    $(@body).html('').append(@elementsContainer, @enterValue, @addButton, @helpBlock)

  _renderElements: ->
    for element in @data.elements
      $(@elementsContainer).append(@_createElement(element))
      @_show @elementsContainer

  _createElement: (element) ->
    $(@element).clone().text(element).val(element).click({obj: @}, @_elementClick)

  _addElement: (element) ->
    value = $(@enterValue).val()
    try
      @data.addElement value
      control = @_createElement value
      $(@elementsContainer).append control
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