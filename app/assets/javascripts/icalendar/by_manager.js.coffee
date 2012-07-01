Classes = exports ? this
$ = jQuery

class Classes.ByManager
  constructor: (@parts, @key = 'parts') ->
    @createBody()

  createBody: ->
    @createSelector()
    @createTabs()
    label = $('<label class="control-label">Parts</label>')
    @body = $('<div></div>').append(
      @groupping(
        label,
        @selector
      ),
      @groupping(
        null,
        @tabs
      )
    )
    return @body

  groupping: (label, controls...)->
    @group = $('<div class="control-group"></div>').append(label)
    @controlsGroup = $('<div class="controls"></div>')
    @controlsGroup.append control for control in controls
    @group.append @controlsGroup
    return @group

  hide: (element) ->
    $(element).addClass('hide').removeClass('active')

  show: (element) ->
    $(element).removeClass('hide')

  createSelector: ->
    @buttonsGroup = $('<div class="btn-group" data-toggle="buttons-checkbox">')
    for part, key in @parts
      $(@buttonsGroup).append(
        $('<button class="btn btn-primary"></button>').
        addClass(part.title).
        attr({
          'data-part': key
          }).
        text(part.title).
        click({obj: @}, @partClick)
      )
    @selector = $('<div></div>').append(@buttonsGroup)

  createTabs: ->
    @tabHeader = $('<ul class="nav nav-tabs"></ul>').addClass('hide')
    @tabBody = $('<div class="tab-content"></div>')
    for part, key in @parts
      id = @randomString()
      $(@tabHeader).append(
        $('<li></li>').addClass('hide', part.title).
        append($('<a></a>').
        attr({
          href: '#by-part-' + id,
          'data-toggle': 'tab'
          }).
        text(part.title ? key))
      )
      $(@tabBody).append(
        $('<div class="tab-pane"></div>').
        addClass('hide').addClass(part.key).
        attr({
          id: 'by-part-' + id
          }).
        append(part.body)
      )
    @tabs = $('<div></div>').append(@tabHeader).append(@tabBody)

  randomString: (length = 5) ->
    chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXTZabcdefghiklmnopqrstuvwxyz'.split('')
    length = Math.floor(Math.random() * chars.length) if !length
    str = '';
    for i in [0...length]
      str += chars[Math.floor(Math.random() * chars.length)]
    return str + (new Date().getTime()).toString();

  partClick: (event) ->
    obj = event.data.obj
    tab = $(obj.tabHeader).find('a').get($(@).attr('data-part'))
    body = $(obj.tabBody).find('.tab-pane').get($(@).attr('data-part'))
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

  partIsActive: (key) ->
    $($(@buttonsGroup).find('button').get(key)).hasClass('active')

  bindFrequency: (frequency) ->
    $(frequency.select).change {obj: @}, (event) ->
      obj = event.data.obj
      for part in obj.parts
        if part.excludeFrequencies.indexOf($(@).val()) >= 0
          obj.hide $(obj.tabs).find('.' + part.key).first()
          obj.hide $(obj.selector).find('.' + part.key).first()
        else
          obj.show $(obj.selector).find('.' + part.key).first()
          $(obj.tabHeader).find('li:not(.hide):first a').tab('show')

  serialize: ->
    data = new Object()
    for part, key in @parts when @partIsActive key
      eval("data." + part.key + " = part.serialize()")
    return data

  deserialize: (data) ->
    for part, key in @parts
      part.deserialize data
    return @
