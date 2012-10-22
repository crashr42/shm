App.module('/cabinet/manager', ->
  $ = jQuery

  $('#search-user').click ->
    unless window.hasOwnProperty('widgets_users_finder')
      box = $('<div></div>')
      window.widgets_users_finder = box.widgets_users_finder
        url: '/cabinet/manager/user/find.json'
        user_selected: (user) -> window.location = '/cabinet/manager/user/show/' + user.id
      $(document.body).append(box)

    window.widgets_users_finder.widgets_users_finder('show')
)