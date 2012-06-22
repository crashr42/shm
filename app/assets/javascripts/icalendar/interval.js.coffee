Classes = exports ? this
$ = jQuery

class Classes.Interval extends Element
  constructor: -> @createBody()

  createBody: ->
    element = $('<input type="text" name="interval">')
    label = $('<label class="control-label">Interval</label>')
    @body = $('<div></div>').append(@groupping(label, element))
    return @body

  getData: ->
    {'interval': $(@body).find('input').val()}