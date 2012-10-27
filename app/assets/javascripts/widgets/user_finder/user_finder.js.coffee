# User finder plugin
(($, window) ->
  pluginName = 'user_finder'
  document = window.document
  defaults =
    # search url
    url: undefined,
    # user selected callback
    selected: (user) ->

  class UserFinder
    methods =
      show: -> @modal.modal('show')
      hide: -> @modal.modal('hide')

    constructor: (@element, options, settings) ->
      @options = defaults
      @_defaults = defaults
      @_name = pluginName
      @init(options, settings)

    # initialize plugin
    init: (options, settings) ->
      @parse_settings(options, settings)
      @init_body()
      @bind_events()

    init_body: ->
      @modal = $(JST['widgets/user_finder/modal'](
        url: @options.url
      ))
      $(document.body).append(@modal)

    bind_events: ->
      that = @
      input_field = @modal.find('input[type=text]')
      users_box = input_field.next()
      input_field.keyup ->
        $.post(that.options.url, {name: input_field.val()}, (request) ->
          users_box.html('')
          for user, index in request
            user_box = JST['widgets/user_finder/user'](
              user: user
              index: index
            )
            users_box.append(user_box)
          users_box.find('button').click -> that.options.selected(request[$(@).attr('data-id')])
        )

    # parse settings and options
    parse_settings: (options, settings) ->
      if typeof options == 'object'
        @options = $.extend {}, defaults, options
      else if typeof options == 'string'
        if @_defaults.hasOwnProperty(options)
          if settings == undefined
            return @options[options]
          else
            @options[options] = settings
        else if methods.hasOwnProperty(options)
          methods[options].call(@, settings)
        else throw("Unrecognized option or method")
      else
        throw "Unknown options type #{typeof options}"
      return undefined

  $.fn[pluginName] = (options, settings) ->
    value = undefined
    objects = @each ->
      unless $.data(@, "plugin_#{pluginName}")
        $.data(@, "plugin_#{pluginName}", new UserFinder(@, options, settings))
      else
        value = $.data(@, "plugin_#{pluginName}").parse_settings(options, settings)
    value || objects
)(jQuery, window)