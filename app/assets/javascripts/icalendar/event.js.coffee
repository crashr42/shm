Classes = exports ? this
$ = jQuery

$(document).ready ->
#  e = new Event()
#  e.deserialize(data)
#  console.log(e)
#  console.log(e.serialize())
  r = new RuleRenderer()
  window.rule = new Rule()
  r.render window.rule
  $('#irrule').append(r.body)


class Classes.Event
  constructor: ->
    @rules = []
    @summary = null
    @description = null
    @date_start = null
    @date_end = null
    @time_start = null
    @time_end = null

  serialize: ->
    rls = []
    rls.push rule.serialize() for rule in @rules
    rules: rls
    summary:      @summary
    description:  @description
    date_start:   @date_start
    date_end:     @date_end
    time_start:   @time_start
    time_end:     @time_end

  deserialize: (object) ->
    throw {message: 'not_alowef_type'} if typeof object == undefined || object == null
    if object.hasOwnProperty('rules') && object.rules instanceof Array
      for rule in object.rules
        r = new Rule()
        r.deserialize(rule)
        @rules.push(r)

    @summary = object.summary if object.hasOwnProperty('summary')
    @description = object.description if object.hasOwnProperty('description')
    @date_start = object.date_start if object.hasOwnProperty('date_start')
    @date_end = object.date_end if object.hasOwnProperty('date_end')
    @time_start = object.time_start if object.hasOwnProperty('time_start')
    @time_end = object.time_end if object.hasOwnProperty('time_end')

#$.fn.extend
#  ievent: (options) ->
#    settings =
#      debug: false
#
#    settings = $.extend settings, options
#
#    log = (msg) ->
#      console?.log msg if settings.debug
#
#    return @each ()->
##      event = new Event()
##      $(@).append event.body
##      m = new ByWeekDays()
##      m.addElement 1, 1
##      m.addElement 1, 2
##      r = new ByArrayNumberRenderer()
##      $(@).append(r.render(m))
#      r = new SelectRenderer()
#      $(@).append(r.render ["SECONDLY", "MINUTELY", "HOURLY", "DAILY", "WEEKLY", "MONTHLY", "YEARLY"], 'Frequency')

#class Classes.Event extends Element
#  constructor: ->
#    @createBody()
#    @rules = []
#
#  createBody: ->
#    @body = $('<div></div>')
#    @summaryLabel = $('<label>Summary</label>')
#    @summary = $('<input type="text" placeholder="summary">')
#    @descriptionLabel = $('<label>Description</label>')
#    @description = $('<input type="text" placeholder="description">')
#    @dateStartLabel = $('<label>Date start</label>')
#    @date_start = $('<input type="text" placeholder="date start">')
#    @time_start = $('<input type="text" placeholder="time start">')
#    @dateEndLabel = $('<label>Date end</label>')
#    @date_end = $('<input type="text" placeholder="date end">')
#    @time_end = $('<input type="text" placeholder="time end">')
#    @buttonsGroup = $('<div class="btn-group">')
#    @buttonHasTime =
#      $('<button class="btn btn-primary" data-toggle="button">Whole day?</button>').
#      click({obj: @}, @hasTimeClick)
#    @recurrenceButton =
#      $('<button class="btn btn-primary" data-toggle="button">Periodical?</button>').
#      click({obj: @}, @periodicalClick)
#    @addRuleButton =
#      $('<button class="btn btn-success hide">Add rule</button>').
#      click({obj: @}, @addRuleClick)
#    @serializeButton =
#      $('<button class="btn btn-primary">Get data</button>').
#      click({obj: @}, @serializeClick)
#    @buttonsGroup.append(
#      @buttonHasTime,
#      @recurrenceButton,
#      @addRuleButton
#    )
#    @createRuleTable()
#    $(@body).append(
#      @groupping(@summaryLabel, @summary),
#      @groupping(@descriptionLabel, @description),
#      @groupping(@dateStartLabel, @date_start, @time_start),
#      @groupping(@dateEndLabel, @date_end, @time_end),
#      @groupping(null, @serializeButton),
#      @groupping(null, @buttonsGroup)
#      @ruleTable
#    )
#
#  createRuleTable: ->
#    @ruleTable = $('<table class="hide table table-bordered table-striped"></table>')
#    $(@ruleTable).append(
#      $('<tr></tr>').append(
#        $('<td>Summary</td>'),
#        $('<td>Function</td>')
#      )
#    )
#
#  createModalEdit: ->
#    modal = $('<div style="width: 1000px; margin-left: -500px;" class="modal"></div>')
#    modalHeader = $('<div class="modal-header"></div>')
#    modalBody = $('<div class="modal-body form-horizontal"></div>')
#    modalFooter = $('<div class="modal-footer"></div>')
#    modalHeaderCloseButton = $('<button class="close" type="button" data-dismiss="modal">x</button>')
#    $(modalHeader).append(modalHeaderCloseButton, $('<h3></h3>'))
#    $(modal).append(modalHeader, modalBody, modalFooter)
#    return modal
#
#  hasTimeClick: (event) ->
#    obj = event.data.obj
#    if $(@).hasClass('active')
#      $(obj.time_start).removeClass('hide')
#      $(obj.time_end).removeClass('hide')
#    else
#      $(obj.time_start).addClass('hide')
#      $(obj.time_end).addClass('hide')
#
#  periodicalClick: (event) ->
#    obj = event.data.obj
#    if $(@).hasClass('active')
#      $(obj.addRuleButton).addClass('hide')
#      $(obj.ruleTable).addClass('hide')
#    else
#      $(obj.addRuleButton).removeClass('hide')
#      $(obj.ruleTable).removeClass('hide') if $(obj.ruleTable).find('tr').length > 1
#
#  addRuleClick: (event) ->
#    obj = event.data.obj
#    obj.createRule()
#
#  selectRule: (rule) ->
#    for div in $(@rruleBody).children('div')
#      $(div).addClass('hide')
#    $(rule.body).removeClass('hide')
#
#  createRule: ->
#    $(@ruleTable).removeClass('hide')
#    rule = new Rule()
#    @rules.push rule
#    $(@ruleTable).removeClass('hide').append(
#      $('<tr></tr>').append(
#        $('<td></td>'),
#        $('<td></td>').append(
#          $('<button class="btn btn-danger">Edit</button>').click({obj: @, rule: rule}, @editButtonClick),
#          $('<button class="btn btn-primary">Delete</button>').click({obj: @, rule: rule}, @deleteButtonClick)
#        )
#      )
#    )
#    modal = @createModalEdit()
#    $(modal).find('.modal-header').first().children('h3').first().text('Rule #' + @rules.length)
#    $(modal).find('.modal-body').first().html(rule.body)
#    $(modal).modal('show')
#
#  editButtonClick: (event) ->
#    obj = event.data.obj
#    rule = event.data.rule
#    obj.editRule rule
#
#  deleteButtonClick: (event) ->
#    obj = event.data.obj
#    rule = event.data.rule
#    obj.deleteRule rule
#
#  editRule: (rule) ->
#    index = @rules.indexOf rule
#    modal = @createModalEdit()
#    $(modal).find('.modal-header').first().children('h3').first().text('Rule #' + (index + 1))
#    $(modal).find('.modal-body').first().html(rule.body)
#    $(modal).modal('show')
#
#  deleteRule: (rule) ->
#    index = @rules.indexOf(rule)
#    $($(@ruleTable).find('tr').get(@rules.length - index)).remove()
#    @rules.splice(index, 1)
#    $(@ruleTable).addClass('hide') if $(@ruleTable).find('tr').length <= 1
#
#  serializeClick: (event) ->
#    s = event.data.obj.serialize(event.data.obj)
##    s.summary = 123
##    s.date_end = 'date_end'
##    console.log s
#    console.log s
#    event.data.obj.deserialize(window.data)
#
#  serialize: ->
#    data =
#      summary: $(@summary).val()
#      description: $(@description).val()
#      date_start: $(@date_start).val()
#      date_end: $(@date_end).val()
#
#    data.time_start = $(@time_start).val() if !$(@buttonHasTime).hasClass('active')
#    data.time_end = $(@time_end).val() if !$(@buttonHasTime).hasClass('active')
#    if @rules.length > 0
#      data.rules = []
#      data.rules.push rule.serialize() for rule in @rules
#    data
#
#  deserialize: (data) ->
#    for property of data
#      if @hasOwnProperty(property) && @[property].hasOwnProperty("deserialize") && typeof @[property].deserialize == "function"
#        @[property] = @[property].deserialize property
#      else
#        $(@[property]).val data[property]
#
#    if data.hasOwnProperty 'rules'
#      rule = new Rule()
#      for r in data.rules
#        @rules.push rule.deserialize r
#      $(@recurrenceButton).removeClass('active').click()
#
#    return @