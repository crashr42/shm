Classes = exports ? this
$ = jQuery

class Classes.Rule
  constructor: ->
    @getByManager().setFrequency(@getFrequency())

  frequencies = ["SECONDLY", "MINUTELY", "HOURLY", "DAILY", "WEEKLY", "MONTHLY", "YEARLY"]

  frequency = "YEARLY"
  getFrequency: -> frequency
  setFrequency: (f) ->
    throw {message: 'frequency_not_alowed'} unless frequencies.indexOf(f.toUpperCase()) >= 0
    frequency = f.toUpperCase()
    @getByManager().setFrequency(frequency)

  interval = 1
  getInterval: -> interval
  setInterval: (i) ->
    throw {message: 'interval_must_be_greate_than_0'} unless parseInt(i) > 0
    interval = i

  untils = null
  getUntil: -> untils
  setUntil: (u) ->
    throw {message: 'until_must_be_greate_than_0'} unless parseInt(u) > 0
    untils = u

  count = null
  getCount: -> count
  setCount: (c) ->
    throw {message: 'count_must_be_greate_than_0'} unless parseInt(c) > 0
    count = c

  byManager = new ByManager()
  getByManager: -> byManager
  setByManager: (m) ->
    throw {message: 'not_alowed_type'} unless m instanceof ByManager
    byManager = m

  serialize: ->
    data =
      frequency: @getFrequency()
      interval: @getInterval()
      count: @getCount()
      until: @getUntil()

    parts = @getByManager().serialize()
    data[key] = value for key, value of parts
    return data

  deserialize: (object) ->
    throw {message: 'not_alowef_type'} if typeof object == undefined || object == null
    @setFrequency(object.frequency) if object.hasOwnProperty('frequency')
    @setInterval(object.interval) if object.hasOwnProperty('interval')
    @setUntil(object.until) if object.hasOwnProperty('until')
    @setCount(object.count )if object.hasOwnProperty('count')
    @getByManager().deserialize(object)
    @onDeserialize(@)
    return @

  onDeserialize: (object) ->