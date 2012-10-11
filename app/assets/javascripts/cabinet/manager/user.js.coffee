$ = jQuery

$(document).ready ->
  $('#user-main-search-form').submit ->
    $.post '/cabinet/manager/user/find', $(@).serialize(), (request) -> $('#user-main-list').html(request)
    return false