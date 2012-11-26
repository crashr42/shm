App.module('idle', ->
  $ = jQuery

  timeout = null
  block_interval = 1000 * 60 * 10

  startTimeout = ->
    timeout = setTimeout(->
      window.location = '/block/new'
    , block_interval)

  restartTimeout = ->
    clearTimeout(timeout) unless timeout == null
    startTimeout()

  startTimeout()

  $(window).bind 'mousemove click mouseup mousedown keydown keypress keyup submit change mouseenter scroll resize dblclick', ->
    restartTimeout()

  $(window).blur ->
    restartTimeout()

  $(window).focus ->
    restartTimeout()
)