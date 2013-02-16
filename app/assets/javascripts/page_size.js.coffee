# Get page size
((window) ->
  plugin = ->
    (($, window) ->
      pluginName = 'pageSize'
      document = window.document

      $[pluginName] = ->
        xScroll = undefined
        yScroll = undefined
        pageWidth = undefined
        pageHeight = undefined
        windowWidth = undefined
        windowHeight = undefined
        if window.innerHeight and window.scrollMaxY
          xScroll = document.body.scrollWidth
          yScroll = window.innerHeight + window.scrollMaxY
        else if document.body.scrollHeight > document.body.offsetHeight # all but Explorer Mac
          xScroll = document.body.scrollWidth
          yScroll = document.body.scrollHeight
        else if document.documentElement and document.documentElement.scrollHeight > document.documentElement.offsetHeight # Explorer 6 strict mode
          xScroll = document.documentElement.scrollWidth
          yScroll = document.documentElement.scrollHeight
        else # Explorer Mac...would also work in Mozilla and Safari
          xScroll = document.body.offsetWidth
          yScroll = document.body.offsetHeight
        if self.innerHeight # all except Explorer
          windowWidth = self.innerWidth
          windowHeight = self.innerHeight
        else if document.documentElement and document.documentElement.clientHeight # Explorer 6 Strict Mode
          windowWidth = document.documentElement.clientWidth
          windowHeight = document.documentElement.clientHeight
        else if document.body # other Explorers
          windowWidth = document.body.clientWidth
          windowHeight = document.body.clientHeight

        # for small pages with total height less then height of the viewport
        if yScroll < windowHeight
          pageHeight = windowHeight
        else
          pageHeight = yScroll

        # for small pages with total width less then width of the viewport
        if xScroll < windowWidth
          pageWidth = windowWidth
        else
          pageWidth = xScroll

        pageWidth: pageWidth
        pageHeight: pageHeight
        windowWidth: windowWidth
        windowHeight: windowHeight
    )(jQuery, window)

  if typeof define == 'function' && define.amd
    define 'page_size', ['jquery'], ($) -> plugin($, window)
  else
    plugin()
)(window);