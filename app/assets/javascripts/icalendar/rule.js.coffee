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
      rrule = new Rule()
      $(@).append rrule.body


class Classes.Rule
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
      new ByMonth(),
      new ByWeekDays()
    ]
    @frequency = new Frequency()
    @byManager = new ByManager(@elements)
    @byManager.bindFrequency @frequency
    @controls = [
      @frequency,
      new Until('no'),
      new Interval(),
      @byManager
    ]
    for control in @controls
      @body.append(control.body)

  getData: (event) ->
    data = {}
    for control in @controls
      eval("data." + control.key + " = control.getData()")
    return data

