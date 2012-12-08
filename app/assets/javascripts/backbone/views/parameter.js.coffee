Shm.Views.Parameter = Backbone.View.extend
  events:
    'click a': 'goto'

  render: (callback) ->
    return callback(@) unless @$el.empty()

    $.get('/cabinet/patient/parameter', $.proxy((response) ->
      @$el.html(response)
      callback(@)
    , @))

  goto: (e) ->
    e.preventDefault()
    target = $(e.currentTarget)
    Shm.Routers.Default.instance().navigate(target.attr('href'), true)