Classes = exports ? this
$ = jQuery

class Classes.ByManager
  constructor: (@frequency = 'YEARLY') ->
    @_all_parts =
      seconds:
        object: new ByNumber([1...60])
      minutes:
        object: new ByNumber([1...60])
      hours:
        object: new ByNumber([1...24])
      month_days:
        object: new ByNumber([-31...0].concat([1...32]))
        excludeFrequencies: ['WEEKLY']
      year_days:
        object: new ByNumber([-366...0].concat([1...367]))
        excludeFrequencies: ['DAILY', 'WEEKLY', 'MONTHLY']
      weeks:
        object: new ByNumber([1...54])
        excludeFrequencies: ['SECONDLY', 'MINUTELY', 'HOURLY', 'DAILY', 'WEEKLY', 'MONTHLY']
      positions:
        object: new ByNumber([1...367])
      months:
        object: new ByNumber(
          1:  "January"
          2:  "February"
          3:  "March"
          4:  "April"
          5:  "May"
          6:  "June"
          7:  "July"
          8:  "August"
          9:  "September"
          10: "October"
          11: "November"
          12: "December"
        )
      week_days:
        object: new ByArrayNumber(
          1: "Monday"
          2: "Tuesday"
          3: "Wednesday"
          4: "Thursday"
          5: "Friday"
          6: "Saturday"
          7: "Sunday", [-53...0].concat([1...54])
        )

  setFrequency: (@frequency) ->

  getParts: ->
    data = {}
    for key, part of @_all_parts
      unless part.hasOwnProperty('excludeFrequencies') && part.excludeFrequencies.indexOf(@frequency) >= 0
        data[key] = part.object
    return data

  serialize: ->
    data = {}
    for key, part of @_all_parts
      unless part.hasOwnProperty('excludeFrequencies') && part.excludeFrequencies.indexOf(@frequency) >= 0
        data[key] = part.object.serialize()
    return data

  deserialize: (data) ->
    for key, part of data
      if @_all_parts.hasOwnProperty key
        @_all_parts[key].object.deserialize part if part != null
    return @

#class Classes.ByManagerRenderer
#  constructor: ->
#    @_renderers =
#      seconds:    new ByNumberRenderer()
#      minutes:    new ByNumberRenderer()
#      hours:      new ByNumberRenderer()
#      month_days: new ByNumberRenderer()
#      year_days:  new ByNumberRenderer()
#      weeks:      new ByNumberRenderer()
#      positions:  new ByNumberRenderer()
#      months:     new ByNumberRenderer()
#      week_days:  new ByArrayNumberRenderer()
#
#  setFrequency: (@frequency) ->
#
#  render: (object) ->
#    @parts = object.getParts()
#    @createSelector()
#    @createTabs()
#    label = $('<label class="control-label">Parts</label>')
#    @body = $('<div></div>').append(
#      @groupping(
#        label,
#        @selector
#      ),
#      @groupping(
#        null,
#        @tabs
#      )
#    )
#    return @body
#
#  _groupping: (label, controls...)->
#    @group = $('<div class="control-group"></div>').append(label)
#    @controlsGroup = $('<div class="controls"></div>')
#    @controlsGroup.append control for control in controls
#    @group.append @controlsGroup
#    return @group
#
#  _hide: (element) ->
#    $(element).addClass('hide').removeClass('active')
#
#  _show: (element) ->
#    $(element).removeClass('hide')
#
#  _createSelector: ->
#    @buttonsGroup = $('<div class="btn-group" data-toggle="buttons-checkbox">')
#    for part, key in @parts
#      $(@buttonsGroup).append(
#        $('<button class="btn btn-primary"></button>').
#        addClass(part.title).
#        attr({
#          'data-part': key
#          }).
#        text(part.title).
#        click({obj: @}, @partClick)
#      )
#    @selector = $('<div></div>').append(@buttonsGroup)
#
#  _createTabs: ->
#    @tabHeader = $('<ul class="nav nav-tabs"></ul>').addClass('hide')
#    @tabBody = $('<div class="tab-content"></div>')
#    for part, key in @parts
#      id = @randomString()
#      $(@tabHeader).append(
#        $('<li></li>').addClass('hide', part.title).
#        append($('<a></a>').
#        attr({
#          href: '#by-part-' + id,
#          'data-toggle': 'tab'
#          }).
#        text(part.title ? key))
#      )
#      $(@tabBody).append(
#        $('<div class="tab-pane"></div>').
#        addClass('hide').addClass(part.key).
#        attr({
#          id: 'by-part-' + id
#          }).
#        append(part.body)
#      )
#    @tabs = $('<div></div>').append(@tabHeader).append(@tabBody)
#
#  _randomString: (length = 5) ->
#    chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz'.split('')
#    length = Math.floor(Math.random() * chars.length) if !length
#    str = '';
#    for i in [0...length]
#      str += chars[Math.floor(Math.random() * chars.length)]
#    return str + (new Date().getTime()).toString();
#
#  _partClick: (event) ->
#    obj = event.data.obj
#    tab = $(obj.tabHeader).find('a').get($(@).attr('data-part'))
#    body = $(obj.tabBody).find('.tab-pane').get($(@).attr('data-part'))
#    if $(@).hasClass('active')
#      active = $(tab).parent().hasClass('active')
#      obj.hide $(tab).parent()
#      obj.hide body
#      $(obj.tabHeader).find('li:not(.hide):first a').tab('show') if active
#      obj.hide obj.tabHeader if $(obj.tabHeader).find('li:not(.hide)').length == 0
#    else
#      obj.show $(tab).tab('show').parent()
#      obj.show body
#      obj.show obj.tabHeader
#
#  _partIsActive: (key) ->
#    $($(@buttonsGroup).find('button').get(key)).hasClass('active')
#
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