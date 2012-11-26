App.module('/cabinet/admin', ->
  App.idle() if (rails.env != 'development') # Редирект на страницу блокировки при долгом бездействии
)