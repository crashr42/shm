# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

App.module('/cabinet/doctor/appointment', ->
  $ = jQuery

  $('#search-patient').click ->
    $(@).user_finder(
      url: '/cabinet/doctor/user/find.json'
      selected: (user) -> window.location = '/cabinet/doctor/user/show/' + user.id
    ).user_finder('show')
)
