Classes = exports ? this
$ = jQuery

#class Classes.ByArrayNumber
#  constructor: (@data, @numbers, @title) ->
#    @elements = []
#    @excludeFrequencies = []
#    @createBody()
#
#  hide: (element) ->
#    $(element).addClass('hide').removeClass('active')
#
#  show: (element) ->
#    $(element).addClass('active').removeClass('hide')
#
#  createBody: ->
#    @body = $('<div></div>')
#    @addButton =
#      $('<button class="btn btn-success">Add value</button>').
#      click({obj: @}, @addButtonClick)
#    @elementsContainer = $('<div class="well-small"></div>')
#    @hide @elementsContainer
#    @element =
#      $('<button class="btn btn-primary" data-key="" data-value=""></button>')
#    @elementsSelector = $('<select></select>')
#    @enterValue = $('<input type="text">')
#    for key, value of @data
#      $(@elementsSelector).append($('<option></option>').val(key).text(value))
#    @helpBlock = $('<p class="help-block"></p>').text(@helpMessage)
#    $(@body).append(@elementsContainer, @enterValue, @elementsSelector, @addButton, @helpBlock)
#
#  addElement: (element) ->
#    unless @checkExits element
#      if @numbers.indexOf(parseInt($(element).attr("data-key"))) >= 0
#        @elements.push $(element).attr("data-key") + "_" + $(element).attr("data-value")
#        $(@elementsContainer).append element
#        @show @elementsContainer
#      else
#        alert "Element must be from " + @numbers.join(',')
#    else
#      alert "Element already exists"
#
#  removeElement: (element) ->
#    if @checkExits element
#      @elements.splice(@elements.indexOf($(element).attr("data-key") + "_" + $(element).attr("data-value")), 1)
#      $(element).remove()
#    @hide @elementsContainer if @elements.length == 0
#
#  checkExits: (element) ->
#    @elements.indexOf($(element).attr("data-key") + "_" + $(element).attr("data-value")) >= 0
#
#  addButtonClick: (event) ->
#    obj = event.data.obj
#    selectedElement = $(obj.elementsSelector).find(':selected')
#    data_day = selectedElement.val()
#    day_text = selectedElement.text()
#    data_number = $(obj.enterValue).val()
#    element = $(obj.element).
#    clone().
#    text([data_number, day_text].join(" ")).
#    attr({
#        'data-key': data_number,
#        'data-value': data_day
#      }).
#    click({obj: obj}, obj.elementClick)
#    obj.addElement element
#
#  elementClick: (event) ->
#    event.data.obj.removeElement @
#
#  serialize: ->
#    @elements
#
#  deserialize: (data) ->

class Classes.ByArrayNumber
  constructor: (@data, @numbers, @key_name) ->
    @numbers = @numbers ? []
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