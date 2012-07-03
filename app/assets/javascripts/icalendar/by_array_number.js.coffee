Classes = exports ? this
$ = jQuery

class Classes.ByArrayNumber
  constructor: (@data, @numbers, @key_name) ->
    @elements = []
    @excludeFrequencies = @excludeFrequencies ? []

  getValue: (key) ->
    return @data[key]

  allowElement: (key1, key2) ->
    @numbers.indexOf(parseInt(key1)) >= 0 && @data.hasOwnProperty key2

  addElement: (key1, key2) ->
    throw {message: "already_exists"} if @checkExits key1, key2
    throw {message: "element_not_alowed"} unless @allowElement key1, key2
    @elements.push [key1, key2].join('_')

  removeElement: (key1, key2) ->
    element = [key1, key2].join('_')
    @elements.splice(@elements.indexOf(element), 1) if @checkExits key1, key2

  checkExits: (key1, key2) ->
    @elements.indexOf([key1, key2].join('_')) >= 0

  serialize: ->
    data = {}
    eval('data.' + @key_name + '=this.elements')
    return data

  deserialize: (data) ->
    @datas = data[@key_name] ? []
    @elements = []
    for d in @datas
      keys = d.split('_')
      @addElement keys[0], keys[1]
    return @

class Classes.ByWeekDays extends ByArrayNumber
  constructor: (@key = 'week_days') ->
    days =
      1: "Monday"
      2: "Tuesday"
      3: "Wednesday"
      4: "Thursday"
      5: "Friday"
      6: "Saturday"
      7: "Sunday"
    super days, [-53...0].concat([1...54]), 'week_days'