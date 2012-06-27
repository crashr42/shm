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
    @getDataButton =
      $('<button class="btn btn-primary">Get data</button>').
      click({obj: @}, @getDataClick)
    @buttonsGroup.
    append(@buttonHasTime).
    append(@recurrenceButton).
    append(@addRRuleButton)
    @createRuleTable()
    $(@body).
    append(@groupping(@summaryLabel, @summary)).
    append(@groupping(@descriptionLabel, @description)).
    append(@groupping(@dateStartLabel, @dateStart, @timeStart)).
    append(@groupping(@dateEndLabel, @dateEnd, @timeEnd)).
    append(@groupping(null, @getDataButton)).
    append(@groupping(null, @buttonsGroup)).
    append(@ruleTable)

  createRuleTable: ->
    @ruleTable = $('<table class="hide table table-bordered table-striped"></table>')
    $(@ruleTable).append(
      $('<tr></tr>').
      append('<td>Summary</td>').
      append('<td>Function</td>')
    )

  createModalEdit: ->
    modal = $('<div style="width: 1000px; margin-left: -500px;" class="modal"></div>')
    modalHeader = $('<div class="modal-header"></div>')
    modalBody = $('<div class="modal-body form-horizontal"></div>')
    modalFooter = $('<div class="modal-footer"></div>')
    modalHeaderCloseButton = $('<button class="close" type="button" data-dismiss="modal">X</button>')
    $(modalHeader).append(modalHeaderCloseButton).append($('<h3></h3>'))
    $(modal).append(modalHeader).append(modalBody).append(modalFooter)
    return modal

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
      $(obj.ruleTable).addClass('hide')
    else
      $(obj.addRRuleButton).removeClass('hide')
      $(obj.ruleTable).removeClass('hide') if $(obj.ruleTable).find('tr').length > 1

  addRRuleClick: (event) ->
    obj = event.data.obj
    obj.createRRule()

  selectRRule: (rrule) ->
    for div in $(@rruleBody).children('div')
      $(div).addClass('hide')
    $(rrule.body).removeClass('hide')

  createRRule: ->
    $(@ruleTable).removeClass('hide')
    rrule = new RRule()
    @rrules.push rrule
    $(@ruleTable).removeClass('hide').append(
      $('<tr></tr>').
      append($('<td></td>')).
      append($('<td></td>').append(
        $('<button class="btn btn-danger">Edit</button>').
        click({obj: @, rule: rrule}, @editButtonClick)
      ).append(
        $('<button class="btn btn-primary">Delete</button>').
        click({obj: @, rule: rrule}, @deleteButtonClick)
      ))
    )
    modal = @createModalEdit()
    $(modal).find('.modal-header').first().children('h3').first().text('Rule #' + @rrules.length)
    $(modal).find('.modal-body').first().html(rrule.body)
    $(modal).modal('show')

  editButtonClick: (event) ->
    obj = event.data.obj
    rule = event.data.rule
    obj.editRule rule

  deleteButtonClick: (event) ->
    obj = event.data.obj
    rule = event.data.rule
    obj.deleteRule rule

  editRule: (rule) ->
    index = @rrules.indexOf rule
    modal = @createModalEdit()
    $(modal).find('.modal-header').first().children('h3').first().text('Rule #' + (index + 1))
    $(modal).find('.modal-body').first().html(rule.body)
    $(modal).modal('show')

  deleteRule: (rule) ->
    index = @rrules.indexOf(rule)
    $($(@ruleTable).find('tr').get(@rrules.length - index)).remove()
    @rrules.splice(index, 1)
    $(@ruleTable).addClass('hide') if $(@ruleTable).find('tr').length <= 1

  getDataClick: (event) ->
    obj = event.data.obj
    obj.validate()

  validate: ->
    @validateSummary()

  validateSummary: ->
    if $(@summary).text() == ''
      $(@summary).attr('placeholder', 'Please enter summary').parent().parent().addClass('error')
