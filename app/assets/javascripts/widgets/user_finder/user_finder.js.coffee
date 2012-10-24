$ = jQuery

methods =
  init: (options) ->
    default_options =
      url: '/'
      user_selected: (user) ->

    options = $.extend default_options, options

    return @each ->
      $(@).append(JST['widgets/user_finder/modal'](
        url: options.url
      ))
      input_field = $(@).find('input[type=text]')
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
  show: -> $(@).find('.modal').modal('show')
  hide: -> $(@).find('.modal').modal('hide')

$.fn.widgets_users_finder = (method) ->
  return methods[method].apply(this, Array.prototype.slice.call(arguments, 1)) if methods[method]
  return methods.init.apply(this, arguments) if typeof method == 'object' || !method
  $.error 'Method ' +  method + ' does not exist on jQuery.widgets_users_finder'