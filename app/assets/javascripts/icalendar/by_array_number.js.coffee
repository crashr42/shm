Classes = exports ? this
$ = jQuery

class Classes.ByArrayNumber
  constructor: (@data, @numbers, @title) ->
    @elements = []
    @createBody()

  hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  show: (element) ->
    $(element).addClass('active').removeClass('hide')

  createBody: ->
    @body = $('<div></div>')
    @addButton =
      $('<button class="btn btn-success">Add value</button>').
      click({obj: @}, @addButtonClick)
    @elementsContainer = $('<div class="well-small"></div>')
    @hide @elementsContainer
    @element =
      $('<button class="btn btn-primary" data-key="" data-value=""></button>')
    @elementsSelector = $('<select></select>')
    @enterValue = $('<input type="text">')
    for key, value of @data
      $(@elementsSelector).append($('<option></option>').val(key).text(value))
    $(@body).append(@elementsContainer, @enterValue, @elementsSelector, @addButton)

  addElement: (element) ->
    unless @checkExits element
      if @numbers.indexOf(parseInt($(element).attr("data-key"))) >= 0
        @elements.push $(element).attr("data-key") + "_" + $(element).attr("data-value")
        $(@elementsContainer).append element
        @show @elementsContainer
      else
        alert "Element must be from " + @numbers.join(',')
    else
      alert "Element already exists"

  removeElement: (element) ->
    if @checkExits element
      @elements.splice(@elements.indexOf($(element).attr("data-key") + "_" + $(element).attr("data-value")), 1)
      $(element).remove()
    @hide @elementsContainer if @elements.length == 0

  checkExits: (element) ->
    @elements.indexOf($(element).attr("data-key") + "_" + $(element).attr("data-value")) >= 0

  addButtonClick: (event) ->
    obj = event.data.obj
    selectedElement = $(obj.elementsSelector).find(':selected')
    data_day = selectedElement.val()
    day_text = selectedElement.text()
    data_number = $(obj.enterValue).val()
    element = $(obj.element).
    clone().
    text([data_number, day_text].join(" ")).
    attr({
        'data-key': data_number,
        'data-value': data_day
      }).
    click({obj: obj}, obj.elementClick)
    obj.addElement element

  elementClick: (event) ->
    event.data.obj.removeElement @

  getData: ->
    @elements

class Classes.ByWeekDays extends ByArrayNumber
  constructor: (@key = 'week_days') ->
    days = new Array()
    days[1] = "Monday"
    days[2] = "Tuesday"
    days[3] = "Wednesday"
    days[4] = "Thursday"
    days[5] = "Friday"
    days[6] = "Saturday"
    days[7] = "Sunday"
    super days, [-53...0].concat([1...54]), 'week_days'

  getData: ->
    data = []
    for element in @elements
      data.push {number: element.split('_')[0], day: element.split('_')[1]}
    return data
