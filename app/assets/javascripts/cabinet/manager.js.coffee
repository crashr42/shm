App.module('/cabinet/manager', ->
  App.idle() if (Rails.env != 'development') # Редирект на страницу блокировки при долгом бездействии

  $ = jQuery

  $('#search-user').click ->
    $(@).user_finder(
      url: '/cabinet/manager/user/find.json'
      selected: (user) -> window.location = '/cabinet/manager/user/show/' + user.id
    ).user_finder('show')
)