$ = jQuery

methods =
  init: (options) ->
    default_options =
      url: '/'
      user_selected: (user) ->
    options = $.extend default_options, options
    return @each ->
      if $(@).data('widget_user_finder') == undefined
        modal = JST['widgets/user_finder/modal'](
          url: options.url
        )
        $(@).data 'widget_user_finder', modal: $(modal), options: options
        $(document.body).append(modal)
  show: -> methods.bind.call(@).modal('show')
  hide: -> $($(@).data('widget_user_finder')).find('.modal').modal('hide')
  bind: ->
    modal = $(@).data('widget_user_finder').modal
    options = $(@).data('widget_user_finder').options
    input_field = modal.find('input[type=text]')
    console.log input_field
    users_box = input_field.next()
    input_field.keyup ->
      $.post(options.url, {name: input_field.val()}, (request) ->
        users_box.html('')
        for user, index in request
          user_box = JST['widgets/user_finder/user'](
            user: user
            index: index
          )
          users_box.append(user_box)
        users_box.find('button').click -> options.user_selected(request[$(@).attr('data-id')])
      )
    return modal

$.fn.user_finder = (method) ->
  return methods[method].apply(this, Array.prototype.slice.call(arguments, 1)) if methods[method]
  return methods.init.apply(this, arguments) if typeof method == 'object' || !method
  $.error 'Method ' +  method + ' does not exist on jQuery.widgets_users_finder'