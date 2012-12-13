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
      @modal = $('
          <div class="modal hide fade">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            <h3>Search user</h3>
          </div>
          <div class="modal-body">
            <div class="row-fluid">
              <input type="text" style="padding: 10px !important; font-size: 18px; height: 40px !important;" class="span12" placeholder="Enter user name">

              <div>

              </div>
            </div>
          </div>
        </div>
      ')
      $(document.body).append(@modal)

    bind_events: ->
      that = @
      input_field = @modal.find('input[type=text]')
      users_box = input_field.next()
      input_field.keyup ->
        $.post(that.options.url, {name: input_field.val()}, (request) ->
          users_box.html('')
          for user, index in request
            user_box = '
              <div class="padding-box5">
                <button type="button" class="btn btn-large span12 text-left" data-id="' + index + '">
                  <i class="icon-user"></i>
                    ' + user.email + '
                </button>
              </div>
            '
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