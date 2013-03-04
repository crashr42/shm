define(['rails'], (Rails) ->
  class Client
    # Зарегистрированные обработчики
    listeners = {}
    # Клиент
    client = undefined
    # Статус клиента
    status = 'close'
    # Очередь сообщений отправленных до открытия клиента
    queue = []

    # Отправка сообщения
    push = (message, type, room = 'all') ->
      sending_message = JSON.stringify({type: type, message: message, room: room})
      # Отправляем сообщение если соединение открыто, в противном случае, добавляем сообщение в очередь
      if status == 'open'
        client.send(sending_message)
      else
        queue.push(sending_message)

    # Обрабатываем очередь сообщений
    processQueue = ->
      for message in queue
        client.send(message)

    # Присоединяем клиента к комнате
    join = (room) -> push('', 'join', room)

    # Отсоединяем клиента от комнаты
    leave = (room) -> push('', 'leave', room)

    userRoom = (event) ->
      if event == undefined
        "user.#{Rails.user}"
      else
        "user.#{Rails.user}.#{event}"

    constructor: ->
      # Устанавливаем соединение
      client = new WebSocket('ws://localhost:8081');
      client.onopen = ->
        status = 'open'
        processQueue()
      client.onmessage = (event) ->
        data = JSON.parse(event.data)
        # Вызываем зарегистрированный обработчик для сообщения
        for key, listener of listeners
          if listener.room == data.room
            listener.cb(data.message)
      client.onclose = -> status = 'close'

    # Отправляем сообщение
    message: (message, room = 'all') -> push(message, 'message', room)

    # Прослушиваем сообщения от сервера
    on: (room, cb) ->
      join(room)
      unless listeners.hasOwnProperty("#{room}#{cb}")
        listeners["#{room}#{cb}"] = room: room, cb: cb

    # Прослушиваем сообщения для текущего пользователя
    userOn: (event, cb) -> @on(userRoom(event), cb)

    userOff: (event, cb = undefined) -> @off(userRoom(event), cb)

    # Отписываемся от прослушки сообщений
    off: (room, cb = undefined) ->
      leave(room)
      delete listeners["#{room}#{cb}"] unless cb == undefined

  new Client()
)