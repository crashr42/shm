Classes = exports ? this
$ = jQuery

class Classes.Rule
  constructor: ->
    @byManager = new ByManager()
    @frequencies = ["SECONDLY", "MINUTELY", "HOURLY", "DAILY", "WEEKLY", "MONTHLY", "YEARLY"]
    @frequency = "YEARLY"
    @interval = 1
    @until = null
    @count = null

  serialize: ->
    data = {
      frequency: @frequency,
      interval: @interval
    }
    parts = @byManager.serialize()
    data[key] = value for key, value of parts
    return data

  deserialize: (object) ->
    @frequency = object.frequency if object.hasOwnProperty('frequency')
    @interval = object.interval if object.hasOwnProperty('interval')
    @until = object.until if object.hasOwnProperty('until')
    @count = object.count if object.hasOwnProperty('count')
    @byManager.deserialize(object)

#class Classes.Rule
#  constructor: ->
#    @createBody()
#
#  createBody: ->
#    @body = $('<div></div>')
#    @elements = [
#      new BySecond(),
#      new ByMinute(),
#      new ByHour(),
#      new ByMonthDay(),
#      new ByYearDay(),
#      new ByWeekNumber(),
#      new ByPosition(),
#      new ByMonth(),
#      new ByWeekDays()
#    ]
#    @frequency = new Frequency()
#    @untils = new Until('no')
#    @interval = new Interval()
#    @byManager = new ByManager(@elements)
#    @byManager.bindFrequency @frequency
#    @controls = [
#      @frequency,
#      @untils,
#      @interval,
#      @byManager
#    ]
#    for control in @controls
#      @body.append(control.body)
#
#  serialize: (event) ->
#    data = {}
#    for control in @controls
#      d = control.serialize()
#      for property of d
#        eval 'data.' + property + '="' + d[property] + '"'
#    return data
#
#  deserialize: (data) ->
#    @frequency.deserialize data
#    @untils.deserialize data
#    @interval.deserialize data
#    @byManager.deserialize data
#    return @
