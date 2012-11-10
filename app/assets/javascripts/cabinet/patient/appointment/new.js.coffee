App.module('/cabinet/patient/appointment/new', ->
  $ = jQuery

  data =
    doctor_id: 0
    event_id: 0

  $('#doctor-selector').click ->
    $(@).user_finder(
      url: '/cabinet/patient/doctor/find'
      selected: (user) -> data.doctor_id = user.id
    ).user_finder('show')
)