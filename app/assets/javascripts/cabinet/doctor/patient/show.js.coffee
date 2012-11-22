App.module('/cabinet/doctor/patient/show', ->
  $ = jQuery

  $('a.parameter-unlink').click ->
    $.post $(@).attr('href'), (request) -> window.location = window.location
    return false

  $('a.parameter-link').click ->
    $.post $(@).attr('href'), (request) -> window.location = window.location
    return false
)