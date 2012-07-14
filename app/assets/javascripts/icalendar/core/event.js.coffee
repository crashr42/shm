Classes = exports ? this
$ = jQuery

#$(document).ready ->
##  e = new Event()
##  e.deserialize(data)
##  console.log(e)
##  console.log(e.serialize())
#  r = new RuleRenderer()
#  window.rule = new Rule()
#  r.render window.rule
#  $('#irrule').append(r.body)


class Classes.Event
  summary = null
  getSummary: -> summary
  setSummary: (s) -> summary = s

  description = null
  getDescription: -> description
  setDescription: (d) -> description = d

  date_start = null
  getDateStart: -> date_start
  setDateStart: (ds) -> date_start = ds

  date_end = null
  getDateEnd: -> date_end
  setDateEnd: (de) -> date_end = de

  time_start = null
  getTimeStart: -> time_start
  setTimeStart: (ts) -> time_start = ts

  time_end = null
  getTimeEnd: -> time_end
  setTimeEnd: (te) -> time_end = te

  rules = []
  getRules: -> rules
  addRule: (r) -> rules.push r
  removeRule: (r) -> rules.splice(rules.indexOf(r), 1)

  serialize: ->
    rls = []
    rls.push rule.serialize() for rule in rules
    rules: rls
    summary:      @getSummary()
    description:  @getDescription()
    date_start:   @getDateStart()
    date_end:     @getDateEnd()
    time_start:   @getTimeStart()
    time_end:     @getTimeEnd()

  deserialize: (object) ->
    throw {message: 'not_alowef_type'} if typeof object == undefined || object == null
    if object.hasOwnProperty('rules') && object.rules instanceof Array
      for rule in object.rules
        r = new Rule()
        r.deserialize(rule)
        rules.push(r)

    @setSummary(object.summary) if object.hasOwnProperty('summary')
    @setDescription(object.description) if object.hasOwnProperty('description')
    @setDateStart(object.date_start) if object.hasOwnProperty('date_start')
    @setDateEnd(object.date_end) if object.hasOwnProperty('date_end')
    @setTimeStart(object.time_start) if object.hasOwnProperty('time_start')
    @setTimeEnd(object.time_end) if object.hasOwnProperty('time_end')
    @onDeserialize(@)
    return @

  onDeserialize: (object) ->