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

  $('#whole_day').click ->
    if $(@).attr('checked') == 'checked'
      $('#time_start').attr('name', '').hide()
      $('#time_end').attr('name', '').hide()
    else
      $('#time_start').attr('name', 'event[time_start]').show()
      $('#time_end').attr('name', 'event[time_end]').show()
