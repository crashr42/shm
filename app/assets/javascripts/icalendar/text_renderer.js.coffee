Classes = exports ? this
$ = jQuery

class Classes.TextRenderer
  _groupping: (label, controls...)->
    group = $('<div class="control-group"></div>').append(label)
    controlsGroup = $('<div class="controls"></div>')
    controlsGroup.append control for control in controls
    group.append controlsGroup
    return group

  render: (text = @default, @title) ->
    @element = $('<input type="text">').val(text)
    @label = $('<label class="control-label"></label>').text(@title)
    @body = $('<div></div>').append(@_groupping(@label, @element))
    return @body