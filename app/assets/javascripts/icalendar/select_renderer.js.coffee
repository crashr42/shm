Classes = exports ? this
$ = jQuery

class Classes.SelectRenderer
  render: (@data, @title) ->
    @_renderSelector()
    @_renderOption(value, value) for value in @data if @data instanceof Array
    @_renderOption(key, value) for key, value of @data if typeof(@numbers) == 'object'
    return @select

  _renderSelector: ->
    @select = $('<select></select>')
    @label = $('<label></label>').text(@title)

  _renderOption: (key, value) ->
    $(@select).append($('<option></option>').val(value).text(key))