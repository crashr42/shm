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
    @rules = []

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
    @addRuleButton =
      $('<button class="btn btn-success hide">Add rule</button>').
      click({obj: @}, @addRuleClick)
    @getDataButton =
      $('<button class="btn btn-primary">Get data</button>').
      click({obj: @}, @getDataClick)
    @buttonsGroup.append(
      @buttonHasTime,
      @recurrenceButton,
      @addRuleButton
    )
    @createRuleTable()
    $(@body).append(
      @groupping(@summaryLabel, @summary),
      @groupping(@descriptionLabel, @description),
      @groupping(@dateStartLabel, @dateStart, @timeStart),
      @groupping(@dateEndLabel, @dateEnd, @timeEnd),
      @groupping(null, @getDataButton),
      @groupping(null, @buttonsGroup)
      @ruleTable
    )

  createRuleTable: ->
    @ruleTable = $('<table class="hide table table-bordered table-striped"></table>')
    $(@ruleTable).append(
      $('<tr></tr>').append(
        $('<td>Summary</td>'),
        $('<td>Function</td>')
      )
    )

  createModalEdit: ->
    modal = $('<div style="width: 1000px; margin-left: -500px;" class="modal"></div>')
    modalHeader = $('<div class="modal-header"></div>')
    modalBody = $('<div class="modal-body form-horizontal"></div>')
    modalFooter = $('<div class="modal-footer"></div>')
    modalHeaderCloseButton = $('<button class="close" type="button" data-dismiss="modal">x</button>')
    $(modalHeader).append(modalHeaderCloseButton, $('<h3></h3>'))
    $(modal).append(modalHeader, modalBody, modalFooter)
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
      $(obj.addRuleButton).addClass('hide')
      $(obj.ruleTable).addClass('hide')
    else
      $(obj.addRuleButton).removeClass('hide')
      $(obj.ruleTable).removeClass('hide') if $(obj.ruleTable).find('tr').length > 1

  addRuleClick: (event) ->
    obj = event.data.obj
    obj.createRule()

  selectRule: (rule) ->
    for div in $(@rruleBody).children('div')
      $(div).addClass('hide')
    $(rule.body).removeClass('hide')

  createRule: ->
    $(@ruleTable).removeClass('hide')
    rule = new Rule()
    @rules.push rule
    $(@ruleTable).removeClass('hide').append(
      $('<tr></tr>').append(
        $('<td></td>'),
        $('<td></td>').append(
          $('<button class="btn btn-danger">Edit</button>').click({obj: @, rule: rule}, @editButtonClick),
          $('<button class="btn btn-primary">Delete</button>').click({obj: @, rule: rule}, @deleteButtonClick)
        )
      )
    )
    modal = @createModalEdit()
    $(modal).find('.modal-header').first().children('h3').first().text('Rule #' + @rules.length)
    $(modal).find('.modal-body').first().html(rule.body)
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
    index = @rules.indexOf rule
    modal = @createModalEdit()
    $(modal).find('.modal-header').first().children('h3').first().text('Rule #' + (index + 1))
    $(modal).find('.modal-body').first().html(rule.body)
    $(modal).modal('show')

  deleteRule: (rule) ->
    index = @rules.indexOf(rule)
    $($(@ruleTable).find('tr').get(@rules.length - index)).remove()
    @rules.splice(index, 1)
    $(@ruleTable).addClass('hide') if $(@ruleTable).find('tr').length <= 1

  getDataClick: (event) ->
    event.data.obj.getData()

  getData: ->
    data =
      summary: $(@summary).val()
      description: $(@description).val()
      dateStart: $(@dateStart).val()
      dateEnd: $(@dateEnd).val()

    data.timeStart = $(@timeStart).val() if !$(@buttonHasTime).hasClass('active')
    data.timeEnd = $(@timeEnd).val() if !$(@buttonHasTime).hasClass('active')
    if @rules.length > 0
      data.rules = []
      data.rules.push rule.getData() for rule in @rules
    console.log data

