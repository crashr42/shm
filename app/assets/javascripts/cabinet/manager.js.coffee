App.module('/cabinet/manager', ->
  $ = jQuery

  $('#search-user').click ->
    $(@).user_finder({
      url: '/cabinet/manager/user/find.json'
      user_selected: (user) -> window.location = '/cabinet/manager/user/show/' + user.id
    }).user_finder('show')
)