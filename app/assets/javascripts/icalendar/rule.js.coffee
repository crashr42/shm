Classes = exports ? this
$ = jQuery

$.fn.extend
  rule: (options) ->
    settings =
      debug: false

    settings = $.extend settings, options

    log = (msg) ->
      console?.log msg if settings.debug

    return @each ()->
      rule = new Rule()
      $(@).append rule.body


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
    @untils = new Until('no')
    @interval = new Interval()
    @byManager = new ByManager(@elements)
    @byManager.bindFrequency @frequency
    @controls = [
      @frequency,
      @untils,
      @interval,
      @byManager
    ]
    for control in @controls
      @body.append(control.body)

  serialize: (event) ->
    data = {}
    for control in @controls
      d = control.serialize()
      for property of d
        eval 'data.' + property + '="' + d[property] + '"'
    return data

  deserialize: (data) ->
    @frequency.deserialize data
    @untils.deserialize data
    @interval.deserialize data
    @byManager.deserialize data
    return @
