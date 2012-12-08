App.module('/cabinet/doctor', ->
  App.idle() if (Rails.env != 'development') # Редирект на страницу блокировки при долгом бездействии
)