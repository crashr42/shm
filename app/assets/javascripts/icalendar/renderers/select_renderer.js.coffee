Classes = exports ? this
$ = jQuery

class Classes.SelectRenderer
  render: (@data, @title) ->
    @_renderSelector()
    @_renderOption(value, value) for value in @data if @data instanceof Array
    @_renderOption(key, value) for key, value of @data if typeof(@data) == 'object'

    return @_groupping($('<label class="control-label"></label>').text(@title), @select)

  _groupping: (label, controls...)->
    group = $('<div class="control-group"></div>').append(label)
    controlsGroup = $('<div class="controls"></div>')
    controlsGroup.append control for control in controls
    group.append controlsGroup
    return group

  _renderSelector: ->
    @select = $('<select></select>')
    @label = $('<label></label>').text(@title)

  _renderOption: (key, value) ->
    $(@select).append($('<option></option>').val(key).text(value))