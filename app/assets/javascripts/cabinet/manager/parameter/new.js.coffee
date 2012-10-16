App.module('/cabinet/manager/parameter/new', ->
  $ = jQuery

  $('.show-parameter-dialog').click -> $("#modal-#{$(@).attr('data-type')}").modal('show')

  do (m = @) ->
    $('#select-p-add-new-value-button').click ->
      $('#select-p-values-box').append JST['cabinet/manager/parameter/select_value'] value: value = $('#select-p-new-value').val()
)