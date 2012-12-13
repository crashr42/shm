define([
  'jquery'
], ($) ->
  class Blocker
    timeout: null
    blockInterval: 1000 * 60 * 10
    active: false

    constructor: ->
      $(window).bind('focus blur mousemove click mouseup mousedown keydown keypress keyup submit change mouseenter scroll resize dblclick', $.proxy(@restart, @))

    stop: ->
      clearTimeout(@timeout) unless @timeout == null
      @active = false

    start: ->
      @timeout = setTimeout(( -> window.location = '/block/new'), @blockInterval)
      @active = true

    restart: ->
      if @active
        @stop()
        @start()

  new Blocker()
)