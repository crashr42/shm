Classes = exports ? this
$ = jQuery

class Classes.TextRenderer
  constructor: (@default, @title) ->

  render: (text = @default) ->
    @element = $('<input type="text">').val(text)
    @label = $('<label></label>').text(@title)
    @body = $('<div></div>').append(@groupping(@label, @element))
    return @body