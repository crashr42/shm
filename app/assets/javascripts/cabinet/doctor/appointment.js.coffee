# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

App.module('/cabinet/doctor/appointment', ->
  $ = jQuery
  
  $('#patient').click ->
    $(@).user_finder(
      url: '/cabinet/doctor/user/find.json'
      selected: (user) ->
      	$('#patient').val(user.email) $('#patient_id').val(user.id) $('#patient').user_finder('hide')
    ).user_finder('show')

  $('#doctor').click ->
    $(@).user_finder(
      url: '/cabinet/doctor/user/find_doctor.json'
      selected: (user) ->
      	$('#doctor').val(user.email) $('#doctor_id').val(user.id) $('#doctor').user_finder('hide')
      ).user_finder('show')

)
