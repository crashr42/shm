Classes = exports ? this
$ = jQuery

$(document).ready ->
#  body = (new Calendar()).createBody()
#  $(document.body).append body

class Classes.Calendar
  createBody: ->
    dr = new DateRange()
    dateStart = new Date()
    dateEnd = new Date()
    dateEnd.setDate(dateStart.getDate() + 1)
    table = dr.createTable(dateStart, dateEnd, new MinutesIncrement(15))

class Classes.DateRange
  createTable: (from, to, incrementator) ->
    table = $('<table class="table table-bordered table-striped"></table>')
    while from < to
      table.append $('<tr></tr>').append $('<td></td>').text from.toLocaleTimeString()
      incrementator.step from
    table

class Classes.MinutesIncrement
  constructor: (@increment) ->

  step: (from) ->
    from.setMinutes(from.getMinutes() + @increment)

class Classes.HoursIncrement
  constructor: (@increment) ->

  step: (from) ->
    from.setHours(from.getHours() + @increment)

class Classes.DayIncrement
  constructor: (@increment) ->

  step: (from) ->
    from.setDate(from.getDate() + @increment)

class Classes.MonthIncrement
  constructor: (@increment) ->

  step: (from) ->
    from.setMonth(from.getMonth() + @increment)