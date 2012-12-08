Shm.Views.Appointment = Backbone.View.extend
  render: (callback) ->
    return callback(@) unless @$el.empty()

    $.get('/cabinet/patient/appointment/new', $.proxy((request) ->
      @$el.html(request)

      (@toolbar = new Shm.Views.Toolbar({el: @$el.find('#toolbar')})).render()
      @result = new Shm.Views.Result({el: @$el.find('#result')})
      @toolbar.selected = $.proxy((id, date) ->
        @result.render(id, date)
      , @)

      callback(@)
    , @))
