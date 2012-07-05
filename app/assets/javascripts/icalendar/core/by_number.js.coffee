Classes = exports ? this
$ = jQuery

class Classes.ByNumber
  constructor: (@numbers) ->
    @numbers = @numbers ? []
    @elements = []

  getValue: (key) ->
    return key if @numbers instanceof Array
    return @numbers[key] if typeof @numbers == 'object' && @numbers.hasOwnProperty key

  allowElement: (key) ->
    (@numbers instanceof Array && @numbers.indexOf(key) >= 0) || (typeof(@numbers) == 'object' && @numbers.hasOwnProperty key)

  addElement: (element) ->
    element = parseInt element
    throw {message: "already_exists"} if @checkExits element
    throw {message: "element_not_alowed"} unless @allowElement element
    @elements.push element

  removeElement: (element) ->
    element = parseInt(element) if @elements instanceof Array
    @elements.splice(@elements.indexOf(element), 1) if @checkExits element

  checkExits: (element) ->
    @elements.indexOf(element) >= 0

  serialize: ->
    @elements

  deserialize: (object) ->
    throw {message: 'not_alowef_type'} if typeof object == undefined || object == null
    @elements = []
    @addElement d for d in object
    return @