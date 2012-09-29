$ = jQuery

$(document).ready ->
  select_find_user = ->
    $('.select-find-user').click ->
      $('#selected-user').html($(@).parent().parent().find('.user-info').first().html())

  $('#select-user').click ->
    $('#modal-select-user').modal('show')

  $('#user-search-form').submit ->
    $.post '/cabinet/manager/event/find', $(@).serialize(), (response) ->
      $('#user-list').html(response)
      select_find_user()
    return false

  $('#name').keydown ->
    $(@).parents('form:first').submit();
