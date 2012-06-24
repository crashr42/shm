Classes = exports ? this
$ = jQuery

Classes = exports ? this
$ = jQuery

$.fn.extend
  ievent: (options) ->
    settings =
      debug: false

    settings = $.extend settings, options

    log = (msg) ->
      console?.log msg if settings.debug

    return @each ()->
      event = new Event()
      $(@).append event.body

class Classes.Event extends Element
  constructor: ->
    @createBody()
    @rrules = []

  createBody: ->
    @body = $('<div></div>')
    @summaryLabel = $('<label>Summary</label>')
    @summary = $('<input type="text" placeholder="summary">')
    @descriptionLabel = $('<label>Description</label>')
    @description = $('<input type="text" placeholder="description">')
    @dateStartLabel = $('<label>Date start</label>')
    @dateStart = $('<input type="text" placeholder="date start">')
    @timeStart = $('<input type="text" placeholder="time start">')
    @dateEndLabel = $('<label>Date end</label>')
    @dateEnd = $('<input type="text" placeholder="date end">')
    @timeEnd = $('<input type="text" placeholder="time end">')
    @buttonsGroup = $('<div class="btn-group">')
    @buttonHasTime =
      $('<button class="btn btn-primary" data-toggle="button">Whole day?</button>').
      click({obj: @}, @hasTimeClick)
    @recurrenceButton =
      $('<button class="btn btn-primary" data-toggle="button">Periodical?</button>').
      click({obj: @}, @periodicalClick)
    @addRRuleButton =
      $('<button class="btn btn-success hide">Add rrule</button>').
      click({obj: @}, @addRRuleClick)
    @buttonsGroup.
    append(@buttonHasTime).
    append(@recurrenceButton).
    append(@addRRuleButton)
    @createRRuleBox()
    $(@body).
    append(@groupping(@summaryLabel, @summary)).
    append(@groupping(@descriptionLabel, @description)).
    append(@groupping(@dateStartLabel, @dateStart, @timeStart)).
    append(@groupping(@dateEndLabel, @dateEnd, @timeEnd)).
    append(@groupping(null, @buttonsGroup)).
    append(@rrulesBody)

  createRRuleBox: ->
    @rrulesBody = $('<div class="hide"></div>')
    @tabBody = $('<div class="span3"></div>')
    @rruleBody = $('<div class="span9"></div>')
    @rrulesTabs = $('<ul class="nav nav-tabs nav-stacked"></ul>')
    $(@rrulesBody).append($(@tabBody).append(@rrulesTabs)).append(@rruleBody)

  hasTimeClick: (event) ->
    obj = event.data.obj
    if $(@).hasClass('active')
      $(obj.timeStart).removeClass('hide')
      $(obj.timeEnd).removeClass('hide')
    else
      $(obj.timeStart).addClass('hide')
      $(obj.timeEnd).addClass('hide')

  periodicalClick: (event) ->
    obj = event.data.obj
    if $(@).hasClass('active')
      $(obj.addRRuleButton).addClass('hide')
      $(obj.rrulesBody).addClass('hide')
    else
      $(obj.addRRuleButton).removeClass('hide')
      $(obj.rrulesBody).removeClass('hide')

  addRRuleClick: (event) ->
    obj = event.data.obj
    obj.createRRule()

  selectRRule: (rrule) ->
    for div in $(@rruleBody).children('div')
      $(div).addClass('hide')
    $(rrule.body).removeClass('hide')

  createRRule: ->
    $(@rrulesBody).removeClass('hide')
    rrule = new RRule()
    @rrules.push rrule
    $(@rruleBody).append(rrule.body)
    for li in $(@tabBody).find('li')
      $(li).removeClass('active')
    @tabButton =
      $('<li class="active"><a>RRule' + @rrules.length + '</a></li>').
      click({obj: @, r: rrule}, @tabClick)
    $(@rrulesTabs).append(@tabButton)
    @selectRRule rrule

  tabClick: (event) ->
    rrule = event.data.r
    obj = event.data.obj
    obj.selectRRule rrule
    for li in $(obj.tabBody).find('li')
      $(li).removeClass('active')
    $(@).addClass('active')
