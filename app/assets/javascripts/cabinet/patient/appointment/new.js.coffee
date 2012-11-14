App.module('/cabinet/patient/appointment/new', ->
  $ = jQuery

  data =
    doctor_id: 0
    event_id: 0

  $('#doctor-selector').click ->
    $(@).user_finder(
      url: '/cabinet/patient/doctor/find'
      selected: (user) ->
        data.doctor_id = user.id
        $('#selected-doctor').text("You select: #{user.email}")
        load_appointment(user.id, moment().unix())
        $('#doctor-selector').user_finder('hide')
    ).user_finder('show')

  load_appointment = (id, date) ->
    $.post '/cabinet/patient/appointment/find', {id: id, date: date}, (request) ->
      $('#appointments').html(request)
      bind_jump_day()
      bind_subscribe_appointment()

  bind_jump_day = ->
    $('.jump-day').click ->
      date = $(@).attr('data-date')
      load_appointment(data.doctor_id, date)
      return false

  bind_subscribe_appointment = ->
    $('.subscribe-appointment').click ->
      event_id = $(@).attr('data-id')
      $.post '/cabinet/patient/appointment', {id: event_id}, (request, status, xhr) ->
        window.location = "/cabinet/patient/appointment/#{event_id}"
)