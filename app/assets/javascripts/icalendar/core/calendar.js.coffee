Classes = exports ? this
$ = jQuery

class Classes.Calendar
  description = null
  getDescription: -> description
  setDescription: (d) -> description = d

  name = null
  getName: -> name
  setName: (n) -> name = n

  events = []
  getEvents: -> events
  addEvent: (e) -> events.push(e)
  removeEvent: (e) -> events.splice(events.indexOf(e), 1)

  serialize: ->
    data =
      name: @getName()
      description: @getDescription()
      events: []

    data.events.push(e.serialize()) for e in events
    return data

  deserialize: (object) ->
    @setName(object.name) if object.hasOwnProperty('name')
    @setDescription(object.description) if object.hasOwnProperty('description')
    if object.hasOwnProperty('events') && object.events instanceof Array
      for e in object.events
        ev = new Classes.Event()
        @addEvent(ev.deserialize(e))
    return @
