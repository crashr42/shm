Shm.Views.Result = Backbone.View.extend
  events:
    'click .jump-day': 'jumpDay'
    'click .subscribe-appointment': 'subscribeAppointment'

  render: (id, date) -> @loadResult(id, date)

  jumpDay: (e) ->
    e.preventDefault()
    target = $(e.currentTarget)
    @loadResult(target.attr('data-id'), target.attr('data-date'))

  loadResult: (id, date) ->
    $.post('/cabinet/patient/appointment/find', {id: id, date: date}, $.proxy((request) ->
      @$el.html(request)
    , @))

  subscribeAppointment: (e) ->
    e.preventDefault()
    target = $(e.currentTarget)
    $.post('/cabinet/patient/appointment', {id: target.attr('data-id')}, $.proxy((request) ->
      target.parent().fadeOut(300, -> $(@).remove())
      $('#subscribe-result .modal-body').html(request)
      $('#subscribe-result').modal('show')
    , @))