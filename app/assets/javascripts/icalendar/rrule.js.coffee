Classes = exports ? this
$ = jQuery

$.fn.extend
  irrule: (options) ->
    settings =
      debug: false

    settings = $.extend settings, options

    log = (msg) ->
      console?.log msg if settings.debug

    return @each ()->
      rrule = new RRule()
      $(@).append rrule.body


class Classes.RRule
  constructor: ->
    @createBody()

  createBody: ->
    @body = $('<div></div>')
    @elements = [
      new BySecond(),
      new ByMinute(),
      new ByHour(),
      new ByMonthDay(),
      new ByYearDay(),
      new ByWeekNumber(),
      new ByPosition(),
      new ByMonth()
    ]
    @byManager = new ByManager(@elements)
    @controls = [
      new Frequency(),
      new Until('no'),
      new Interval(),
      @byManager
    ]
    $(@body).append($('<button>Get data</button>').click({obj: @}, @getData))
    for control in @controls
      @body.append(control.body)

  getData: (event) ->
    obj = event.data.obj
    data = new Object()
    for control in obj.controls
      eval("data." + control.key + " = control.getData()")
    console.log(data)
    return data

