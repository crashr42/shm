Classes = exports ? this
$ = jQuery

class Classes.Frequency extends Element
  constructor: -> @createBody()

  frequencies = ["SECONDLY", "MINUTELY", "HOURLY", "DAILY", "WEEKLY", "MONTHLY", "YEARLY"]

  createBody: ->
    select = $('<select></select>')
    for frequency in frequencies.reverse()
      option = $('<option></option>').val(frequency).text(frequency)
      $(select).append option
    label = $('<label class="control-label">Frequency</label>')
    @body = $('<div></div>').append(@groupping(label, select))
    return @body

  getData: ->
    {'frequency': $(@body).find('option:selected').val()}