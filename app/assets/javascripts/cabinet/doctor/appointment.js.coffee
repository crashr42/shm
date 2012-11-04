# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

App.module('/cabinet/doctor/appointment', ->
  $ = jQuery

  $('#name').keyup -> $(@).parents('form:first').submit();

  $('#user-main-search-form').submit ->
    $.post '/cabinet/doctor/user/find', $(@).serialize(), (request) -> $('#user-main-list').html(request)

    return false
)
