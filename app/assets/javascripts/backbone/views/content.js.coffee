Shm.Views.Content = Backbone.View.extend
  initialize: ->
    @appointment = new Shm.Views.Appointment(parentView: @)
    @index = new Shm.Views.Index(parentView: @)
    @parameter = new Shm.Views.Parameter(parentView: @)

  showIndex: ->
    if @indexRendered
      @index.$el.show()
    else
      @index.render $.proxy((v) ->
        @$el.append(v.el)
        @indexRendered = true
      , @)

    @appointment.$el.hide() if @appointmentRendered
    @parameter.$el.hide() if @parameterRendered

  showAppointment: ->
    if @appointmentRendered
      @appointment.$el.show()
    else
      @appointment.render $.proxy((v) ->
        @$el.append(v.el)
        @appointmentRendered = true
      , @)

    @index.$el.hide() if @indexRendered
    @parameter.$el.hide() if @parameterRendered

  showParameter: ->
    if @parameterRendered
      @parameter.$el.show()
    else
      @parameter.render $.proxy((v) ->
        @$el.append(v.el)
        @parameterRendered = true
      , @)

    @index.$el.hide() if @indexRendered
    @appointment.$el.hide() if @appointmentRendered