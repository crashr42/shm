App.module('/cabinet/manager/user', ->
  $ = jQuery

  $('#name').keyup -> $(@).parents('form:first').submit();

  $('#user-main-search-form').submit ->
    $.post '/cabinet/manager/user/find', $(@).serialize(), (request) -> $('#user-main-list').html(request)
    return false
)