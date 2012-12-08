Shm.Routers.Default = Backbone.Router.extend
  initialize: (options) ->
    @app = options.app

  routes:
    'cabinet/patient': 'index'
    'cabinet/patient/appointment/new': 'appointment#new'
    'cabinet/patient/parameter': 'parameter#index'
    'cabinet/patient/parameter/:id/edit': 'parameter#edit'

  'index': ->
    @app.content.showIndex()

  'appointment#new': ->
    @app.content.showAppointment()

  'parameter#index': ->
    @app.content.showParameter()

  'parameter#edit': ->


Shm.Routers.Default.instance = (options) ->
  unless Shm.Routers.Default._instance
    Shm.Routers.Default._instance = new Shm.Routers.Default(options)

  return Shm.Routers.Default._instance