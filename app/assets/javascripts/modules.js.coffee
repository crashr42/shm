window.App =
  module: (key, func) -> @[key] = func
  module_name: -> document.body.getAttribute('data-controller') + '/' + document.body.getAttribute('data-action')
  load_module: ->
    modules = []
    temp_key = ''
    keys = @.module_name().split('/')

    for key in keys
      modules.push((temp_key += '/' + key))

    for module in modules
      @[module].call({module_name: module}) if @.hasOwnProperty(module)