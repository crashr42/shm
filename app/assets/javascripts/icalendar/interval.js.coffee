Classes = exports ? this
$ = jQuery

class Classes.Interval extends Element
  constructor: (@key = 'interval') -> @createBody()

  createBody: ->
    @element = $('<input type="text" name="interval">')
    @label = $('<label>Interval</label>')
    @helpBlock = $('<p class="help-block"></p>').text('Interval must be a positive number.')
    @body = $('<div></div>').append(@groupping(@label, @element, @helpBlock))
    return @body

  getData: ->
    $(@element).val()