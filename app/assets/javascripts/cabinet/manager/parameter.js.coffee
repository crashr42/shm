App.module('/cabinet/manager/parameter', ->
  $ = jQuery

  do (m = @) ->
    $('#select-p-add-new-value-button').click ->
      $('#select-p-values-box').append JST['cabinet/manager/parameter/select_value'] value: value = $('#select-p-new-value').val()
)