App.module('/cabinet/manager/recurrence', ->
  $ = jQuery

  $(document).ready ->
    select_find_event = ->
      $('.select-find-event').click ->
        $('#selected-event').html($(@).parent().parent().find('.event-info').first().html())

    $('#select-event').click ->
      $('#modal-select-event').modal('show')

    $('#event-search-form').submit ->
      $.post '/cabinet/manager/rule/find', $(@).serialize(), (response) ->
        $('#event-list').html(response)
        select_find_event()
      return false

    $('#name').keydown ->
      $(@).parents('form:first').submit();

    $('#frequency').change -> $('#frequency-block').html($("##{$(@).val()}").html())

    $('#until').change ->
      $('#until-block').html($("#until_#{$(@).val()}").html())
      bind_datepicker()
)