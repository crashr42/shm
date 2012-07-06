Classes = exports ? this
$ = jQuery

class Classes.ByArrayNumberRenderer
  render: (@data) ->
    unless @data instanceof ByArrayNumber
      throw
        message: 'instance_type_not_alowed'

    d = @
    @data.onDeserialize = (object) ->
      d.render object

    @_createBody()
    @_renderElements()
    return @body

  _hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  _show: (element) ->
    $(element).removeClass('hide')

  _createBody: ->
    @body = @body ? $('<div></div>')
    @addButton = $('<button class="btn btn-success">Add value</button>').click({obj: @}, @_addButtonClick)
    @elementsContainer = $('<div class="well-small"></div>')
    @_hide @elementsContainer
    @element = $('<button class="btn btn-primary" data-key=""></button>')
    @elementsSelector = $('<select></select>')
    @enterValue = $('<input type="text">')
    $(@elementsSelector).append($('<option></option>').val(key).text(value)) for key, value of @data.data
    @helpBlock = $('<p class="help-block"></p>').text(@helpMessage)
    $(@body).html('').append(@elementsContainer, @enterValue, @elementsSelector, @addButton, @helpBlock)

  _renderElements: ->
    for element in @data.elements
      keys = element.split('_')
      text = [keys[0], @data.data[keys[1]]].join(' ')
      element = @_createElement(text, keys[0], keys[1])
      $(@elementsContainer).append element
      @_show @elementsContainer

  _addElement: ->
    selectedElement = $(@elementsSelector).find(':selected')
    key1 = $(@enterValue).val()
    key2 = selectedElement.val()
    text = [key1, selectedElement.text()].join(' ')
    element = @_createElement(text, key1, key2)
    @data.addElement key1, key2
    $(@elementsContainer).append element
    @_show @elementsContainer

  _createElement: (text, key1, key2) ->
    $(@element).clone().text(text).prop('data-key', [key1, key2].join('_')).click({obj: @}, @_elementClick)

  _removeElement: (element) ->
    keys = $(element).prop('data-key').split('_')
    @data.removeElement keys[0], keys[1]
    $(element).remove()
    @_hide @elementsContainer if @data.elements.length == 0

  _addButtonClick: (event) ->
    event.data.obj._addElement()

  _elementClick: (event) ->
    event.data.obj._removeElement @