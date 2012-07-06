Classes = exports ? this
$ = jQuery

class Classes.SelectRenderer
  render: (@data, @title) ->
    @_renderSelector()
    @_renderOption(value, value) for value in @data if @data instanceof Array
    @_renderOption(key, value) for key, value of @data if typeof(@data) == 'object' && !(@data instanceof Array)

    return @_groupping($('<label class="control-label"></label>').text(@title), @element)

  _groupping: (label, controls...)->
    group = $('<div class="control-group"></div>').append(label)
    controlsGroup = $('<div class="controls"></div>')
    controlsGroup.append control for control in controls
    group.append controlsGroup
    return group

  _renderSelector: ->
    @element = $('<select></select>')
    @label = $('<label></label>').text(@title)

  _renderOption: (key, value) ->
    $(@element).append($('<option></option>').val(key).text(value))