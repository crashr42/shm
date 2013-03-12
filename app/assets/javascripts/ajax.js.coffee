define([
  'jquery',
  'binder',
  'notification'
], ($, Binder, Notification) ->
  class Loader
    constructor: ->
      $('body').append(@loader())
      @bind()

    loader: ->
      loader = $('.loader')
      unless loader.length > 0
        loader = $('<div class="loader"><span>Загрузка...</span></div>')
      loader

    show: ->
      @loader().show()

    hide: ->
      @loader().hide()

    bind: ->
      $(document).ajaxStart $.proxy (e) ->
        @show()
      , @

      $(document).ajaxError $.proxy (event, xhr, settings, error) ->
        console.log
          event: event
          xhr: xhr
          settings: settings
          error: error

        @hide()
        Notification.error(error)
      , @

      $(document).ajaxSuccess $.proxy ->
        @hide()
        Binder.bind()
      , @

      $(document).ajaxComplete $.proxy ->
        @hide()
      , @

      $.ajaxSetup beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))

  new Loader()
)
