getLoader = ->
  loader = $('.loader')
  unless loader.length > 0
    loader = $('<div class="loader" style="display: none;"></div>')
    $('body').append(loader)

  loader

$(document).ajaxStart -> getLoader().show()

$(document).ajaxError ->
  alert('error!!!!')
  getLoader().hide()

$(document).ajaxSuccess -> getLoader().hide()
