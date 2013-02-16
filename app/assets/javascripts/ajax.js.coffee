define([
  'jquery',
  'binder',
  'notification'
], ($, Binder, Notification) ->
  getLoader = ->
    loader = $('.loader')
    unless loader.length > 0
      loader = $('<div class="loader"><span>Загрузка...</span></div>')
      $('body').append(loader)
    loader

#  $(document).ajaxStart (e) -> getLoader().stop().fadeIn('fast')

  $(document).ajaxError (event, xhr, settings, error) ->
    console.log(
      event: event
      xhr: xhr
      settings: settings
      error: error
    )
    getLoader().stop().fadeOut('fast')
    Notification.error(error)

  $(document).ajaxSuccess ->
    getLoader().stop().fadeOut('fast')
    Binder.bind()

  $(document).ajaxComplete ->
    getLoader().stop().fadeOut('fast')

  $.ajaxSetup beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
)
