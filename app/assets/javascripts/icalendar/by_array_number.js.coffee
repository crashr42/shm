Classes = exports ? this
$ = jQuery

class Classes.ByArrayNumber
  constructor: (@data, @numbers) ->
    @elements = []

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
    @elements

  deserialize: (data) ->
    throw {message: 'not_alowef_type'} if typeof object == undefined || object == null
    @elements = []
    @addElement d.split('_')[0], d.split('_')[1] for d in data
    return @