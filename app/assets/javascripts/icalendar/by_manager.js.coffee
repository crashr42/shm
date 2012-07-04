Classes = exports ? this
$ = jQuery

class Classes.ByManager
  constructor: (@frequency = 'YEARLY') ->
    @_all_parts =
      seconds:
        object: new ByNumber([1...60])
      minutes:
        object: new ByNumber([1...60])
      hours:
        object: new ByNumber([1...24])
      month_days:
        object: new ByNumber([-31...0].concat([1...32]))
        excludeFrequencies: ['WEEKLY']
      year_days:
        object: new ByNumber([-366...0].concat([1...367]))
        excludeFrequencies: ['DAILY', 'WEEKLY', 'MONTHLY']
      weeks:
        object: new ByNumber([1...54])
        excludeFrequencies: ['SECONDLY', 'MINUTELY', 'HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY']
      positions:
        object: new ByNumber([1...367])
      months:
        object: new ByNumber(
          1:  "January"
          2:  "February"
          3:  "March"
          4:  "April"
          5:  "May"
          6:  "June"
          7:  "July"
          8:  "August"
          9:  "September"
          10: "October"
          11: "November"
          12: "December"
        )
      week_days:
        object: new ByArrayNumber(
          1: "Monday"
          2: "Tuesday"
          3: "Wednesday"
          4: "Thursday"
          5: "Friday"
          6: "Saturday"
          7: "Sunday", [-53...0].concat([1...54])
        )

  setFrequency: (@frequency) ->

  getParts: ->
    data = {}
    for key, part of @_all_parts
      unless part.hasOwnProperty('excludeFrequencies') && part.excludeFrequencies.indexOf(@frequency) >= 0
        data[key] = part.object
    return data

  serialize: ->
    data = {}
    for key, part of @_all_parts
      unless part.hasOwnProperty('excludeFrequencies') && part.excludeFrequencies.indexOf(@frequency) >= 0
        data[key] = part.object.serialize()
    return data

  deserialize: (data) ->
    for key, part of data
      if @_all_parts.hasOwnProperty key
        @_all_parts[key].object.deserialize part if part != null
    return @