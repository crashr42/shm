Classes = exports ? this
$ = jQuery

class Classes.ByArrayRenderer
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
    @elementsSelector = $('<select></select>')
    $(@elementsSelector).append($('<option></option>').val(key).text(value)) for key, value of @data
    @helpBlock = $('<p class="help-block"></p>').text(@helpMessage)
    $(@body).append(@elementsContainer, @elementsSelector, @addButton, @helpBlock)

  _renderElements: ->
    for element in @data.elements
      el = @_createElement(element)
      $(@elementsContainer).append(el)
      $(@elementsSelector).find("option[value=#{value}]").addClass('hide')
      if $(@elementsSelector).find('option:not(.hide)').length != 0
        $(@elementsSelector).find('option:not(.hide):first').attr('selected', 'selected')
      else
        $(@elementsSelector).addClass('hide')
        $(@addButton).addClass('hide')
      @_show @elementsContainer

  _addElement: ->
    value = $(obj.elementsSelector).find(':selected').val()
    try
      @data.addElement value
      element = @_createElement value
      $(@elementsContainer).append element
      $(@elementsSelector).find("option[value=#{value}]").addClass('hide')
      if $(@elementsSelector).find('option:not(.hide)').length != 0
        $(@elementsSelector).find('option:not(.hide):first').attr('selected', 'selected')
      else
        $(@elementsSelector).addClass('hide')
        $(@addButton).addClass('hide')
      @_show @elementsContainer
    catch e

  _createElement: (value) ->
    $(obj.element).clone().text(@data.getValue(value)).val(value).click({obj: @}, @_elementClick)

  _removeElement: (element) ->
    @data.removeElement $(element).val()
    $(@elementsSelector).removeClass('hide')
    $(@addButton).removeClass('hide')
    $(@elementsSelector).find("option[value=#{$(element).val()}]").removeClass('hide')
    $(element).remove()
    @_hide @elementsContainer if @data.elements.length == 0

  _addButtonClick: (event) ->
    event.data.obj._addElement

  _elementClick: (event) ->
    event.data.obj._removeElement @