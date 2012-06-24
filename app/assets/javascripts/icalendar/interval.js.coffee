Classes = exports ? this
$ = jQuery

class Classes.Interval extends Element
  constructor: (@key = 'interval') -> @createBody()

  createBody: ->
    @element = $('<input type="text" name="interval">')
    @label = $('<label>Interval</label>')
    @body = $('<div></div>').append(@groupping(@label, @element))
    return @body

  getData: ->
    $(@element).val()