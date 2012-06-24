Classes = exports ? this
$ = jQuery

class Classes.Element
  groupping: (label, controls...)->
    $(label).addClass('control-label')
    @group = $('<div class="control-group"></div>').append(label)
    @controlsGroup = $('<div class="controls"></div>')
    @controlsGroup.append control for control in controls
    @group.append @controlsGroup
    return @group

  hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  show: (element) ->
    $(element).addClass('active').removeClass('hide')