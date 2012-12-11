# Переписать!!!
getLoader = ->
  loader = $('.loader')
  unless loader.length > 0
    loader = $('<div class="loader" style="display: none;"></div>')
    $('body').append(loader)

  loader

$(document).ajaxStart -> getLoader().show()

$(document).ajaxError (event, jqXHR, ajaxSettings, thrownError) ->
  alert(thrownError)
  getLoader().hide()

$(document).ajaxSuccess -> getLoader().hide()
$(document).ajaxComplete -> getLoader().hide()
$.ajaxSetup beforeSend: (xhr) -> xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))