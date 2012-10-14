App.module('/cabinet/manager/event', ->
  $ = jQuery

  $(document).ready ->
    select_find_user = ->
      $('.select-find-user').click ->
        $('#selected-user').html($(@).parent().parent().find('.user-info').first().html())

    $('#select-user').click -> $('#modal-select-user').modal('show')

    $('#user-search-form').submit ->
      $.post '/cabinet/manager/event/find', $(@).serialize(), (response) ->
        $('#user-list').html(response)
        select_find_user()
      return false

    $('#name').keyup -> $(@).parents('form:first').submit();

    $('#whole_day').click ->
      if $(@).attr('checked') == 'checked'
        $('#time_start').attr('name', '').hide()
        $('#time_end').attr('name', '').hide()
      else
        $('#time_start').attr('name', 'event[time_start]').show()
        $('#time_end').attr('name', 'event[time_end]').show()

    select_attendee_user = ->
      $('.select-attendee-user').click ->
        div = $('<div class="alert alert-info"><a class="close" data-dismiss="alert" href="#">&times;</a></div>')
        $('#selected-attendee').append(div.append($(@).parent().parent().find('.user-info').first().html()))

    $('#attendee-name').keyup -> $(@).parents('form:first').submit();

    $('#add-attendee-to-event').click -> $('#modal-select-attendee-user').modal('show')

    $('#attendee-user-search-form').submit ->
      $.post '/cabinet/manager/event/find_attendee', $(@).serialize(), (response) ->
        $('#attendee-user-list').html(response)
        select_attendee_user()
      return false
)