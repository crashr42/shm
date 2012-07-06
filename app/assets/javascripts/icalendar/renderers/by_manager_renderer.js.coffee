Classes = exports ? this
$ = jQuery

class Classes.ByManagerRenderer
  constructor: ->
    @_renderers =
      seconds:
        title: 'Seconds'
        renderer: new ByNumberRenderer()
      minutes:
        title: 'Minutes'
        renderer: new ByNumberRenderer()
      hours:
        title: 'Hours'
        renderer: new ByNumberRenderer()
      month_days:
        title: 'Month days'
        renderer: new ByNumberRenderer()
      year_days:
        title: 'Year days'
        renderer: new ByNumberRenderer()
      weeks:
        title: 'Weeks'
        renderer: new ByNumberRenderer()
      positions:
        title: 'Positions'
        renderer: new ByNumberRenderer()
      months:
        title: 'Months'
        renderer: new ByNumberRenderer()
      week_days:
        title: 'Week days'
        renderer: new ByArrayNumberRenderer()

  setFrequency: (frequency) ->

  render: (object) ->
    @setFrequency = (frequency) ->
      object.setFrequency(frequency)
      @render object
    d = @
    object.onDeserialize = (o) -> d.render o

    @parts = object.getParts()
    @_createSelector()
    @label = $('<label class="control-label">Parts</label>')
    @body = @body ? $('<div></div>')
    $(@body).html('').append(@_groupping(@label, @selector), @_groupping(null, @tabs))
    return @body

  _groupping: (label, controls...)->
    group = $('<div class="control-group"></div>').append(label)
    controlsGroup = $('<div class="controls"></div>')
    controlsGroup.append control for control in controls
    group.append controlsGroup
    return group

  _hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  _show: (element) ->
    $(element).removeClass('hide')

  _createSelector: ->
    @buttonsGroup = $('<div class="btn-group">')
    @tabHeader = $('<ul class="nav nav-tabs hide"></ul>')
    @tabBody = $('<div class="tab-content"></div>')
    for key, part of @parts
      tab = $('<li></li>').append($('<a data-toggle="tab"></a>').attr({href: '#by-part-' + key}).text(@_renderers[key].title))
      @_hide tab
      $(@tabHeader).append tab

      tabPanel = $('<div class="tab-pane"></div>').attr({id: 'by-part-' + key}).append(@_renderers[key].renderer.render(part))
      @_hide tabPanel
      $(@tabBody).append tabPanel

      button = $('<button class="btn btn-primary"></button>').text(@_renderers[key].title).click({obj: @, tab: tab, tabPanel: tabPanel}, @_partClick)
      $(@buttonsGroup).append button
      $(button).click() if part.elements.length > 0
    @selector = $('<div></div>').append(@buttonsGroup)
    @tabs = $('<div></div>').append(@tabHeader).append(@tabBody)

  _partClick: (event) ->
    event.data.obj._selectTab @, event.data.tab, event.data.tabPanel

  _selectTab: (button, tab, tabPanel) ->
    if $(button).hasClass('active')
      active = $(tab).hasClass('active')
      @_hide tab
      @_hide tabPanel
      $(@tabHeader).find('li:not(.hide):first a').tab('show') if active
      @_hide @tabHeader if $(@tabHeader).find('li:not(.hide)').length == 0
    else
      $(@tabBody).children('div').addClass('hide').removeClass('active')
      @_show $(tabPanel).addClass('active')
      @_show @tabHeader
      @_show $(tab).find('a').tab('show').parent()
    $(button).button('toggle')

  _partIsActive: (key) ->
    $($(@buttonsGroup).find('button').get(key)).hasClass('active')