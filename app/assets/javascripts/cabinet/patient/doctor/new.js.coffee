App.module('/cabinet/patient/doctor/new', ->
  $ = jQuery

  $('.show-doctor-info').click ->
    $.get '/cabinet/patient/doctor/show/' + $(@).attr('data-id'), (request) -> $('#doctor-info-box').html(request)
)