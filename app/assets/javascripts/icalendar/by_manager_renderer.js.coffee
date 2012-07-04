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

  setFrequency: (@frequency) ->

  render: (object) ->
    @parts = object.getParts()
    @_createSelector()
    @_createTabs()
    label = $('<label class="control-label">Parts</label>')
    @body = $('<div></div>').append(
      @_groupping(
        label,
        @selector
      ),
      @_groupping(
        null,
        @tabs
      )
    )
    return @body

  _groupping: (label, controls...)->
    @group = $('<div class="control-group"></div>').append(label)
    @controlsGroup = $('<div class="controls"></div>')
    @controlsGroup.append control for control in controls
    @group.append @controlsGroup
    return @group

  hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  show: (element) ->
    $(element).removeClass('hide')

  _createSelector: ->
    @buttonsGroup = $('<div class="btn-group" data-toggle="buttons-checkbox">')
    for key, part of @parts
      $(@buttonsGroup).append(
        $('<button class="btn btn-primary"></button>').
        addClass(key).
        attr({
          'data-part': key
          }).
        text(@_renderers[key].title).
        click({obj: @}, @_partClick)
      )
    @selector = $('<div></div>').append(@buttonsGroup)

  _createTabs: ->
    @tabHeader = $('<ul class="nav nav-tabs"></ul>').addClass('hide')
    @tabBody = $('<div class="tab-content"></div>')
    for key, part of @parts
      $(@tabHeader).append(
        $('<li></li>').addClass('hide', key).
        append($('<a></a>').
        attr({
          href: '#by-part-' + key,
          'data-toggle': 'tab'
          }).
        text(@_renderers[key].title))
      )
      $(@tabBody).append(
        $('<div class="tab-pane"></div>').
        addClass('hide').
        attr({
          id: 'by-part-' + key
          }).
        append(@_renderers[key].renderer.render(part))
      )
    @tabs = $('<div></div>').append(@tabHeader).append(@tabBody)

  _partClick: (event) ->
    obj = event.data.obj
    tab = $(obj.tabHeader).find('a[href=#by-part-' + $(@).attr('data-part') + ']')
    body = $(obj.tabBody).find('#by-part-' + $(@).attr('data-part'))
    if $(@).hasClass('active')
      active = $(tab).parent().hasClass('active')
      obj.hide $(tab).parent()
      obj.hide body
      $(obj.tabHeader).find('li:not(.hide):first a').tab('show') if active
      obj.hide obj.tabHeader if $(obj.tabHeader).find('li:not(.hide)').length == 0
    else
      obj.show $(tab).tab('show').parent()
      obj.show body
      obj.show obj.tabHeader

  _partIsActive: (key) ->
    $($(@buttonsGroup).find('button').get(key)).hasClass('active')

#  _bindFrequency: (frequency) ->
#    $(frequency.select).change {obj: @}, (event) ->
#      obj = event.data.obj
#      for part in obj.parts
#        if part.excludeFrequencies.indexOf($(@).val()) >= 0
#          obj.hide $(obj.tabs).find('.' + part.key).first()
#          obj.hide $(obj.selector).find('.' + part.key).first()
#        else
#          obj.show $(obj.selector).find('.' + part.key).first()
#          $(obj.tabHeader).find('li:not(.hide):first a').tab('show')