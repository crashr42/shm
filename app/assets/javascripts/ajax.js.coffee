define([
  'jquery'
], ($) ->
  getLoader = ->
    loader = $('.loader')
    unless loader.length > 0
      loader = $('
        <div class="loader"><span>Loading...</span></div>
      ')
      $('body').append(loader)
    loader

  $(document).ajaxStart -> getLoader().show()

  $(document).ajaxError (event, xhr, settings, error) ->
    console.log(
      event: event
      xhr: xhr
      settings: settings
      error: error
    )
    getLoader().hide()

  $(document).ajaxSuccess -> getLoader().hide()
  $(document).ajaxComplete -> getLoader().hide()
  $.ajaxSetup beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))
)
