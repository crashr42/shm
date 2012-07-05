Classes = exports ? this
$ = jQuery

class Classes.Frequency
  constructor: (@frequency = "YEARLY") ->
    @frequencies = ["SECONDLY", "MINUTELY", "HOURLY", "DAILY", "WEEKLY", "MONTHLY", "YEARLY"]

  current: (@frequency = @frequency) -> @frequency

  serialize: ->
    @frequency

  deserialize: (data) ->
    throw {message: 'frequency_not_alowed'} unless @frequencies.indexOf(data) >= 0
    @frequency = data

#class Classes.Frequency extends Element
#  constructor: (@key = 'frequency') ->
#    @frequencies = ["SECONDLY", "MINUTELY", "HOURLY", "DAILY", "WEEKLY", "MONTHLY", "YEARLY"]
#    @createBody()
#
#  createBody: ->
#    @select = $('<select></select>')
#    for frequency in @frequencies.reverse()
#      option = $('<option></option>').val(frequency).text(frequency)
#      $(@select).append option
#    @label = $('<label>Frequency</label>')
#    @body = $('<div></div>').append(@groupping(@label, @select))
#    return @body
#
#  serialize: ->
#    $(@body).find('option:selected').val()