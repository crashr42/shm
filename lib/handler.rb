class Handler
  # Присоединение клиента к какому-либо каналу
  def join(ws, clients, rooms, message)
    unless clients[ws][:rooms].key?(message[:room])
      clients[ws][:rooms][message[:room]] = {
          :channel => rooms[message[:room]],
          :sid => rooms[message[:room]].subscribe { |msg| ws.send msg }
      }
      message(ws, clients, rooms, message)
    end
  end

  # отправка сообщения
  def message(ws, clients, rooms, message)
    if !message.nil? && message.key?(:room)
      clients[ws][:rooms][message[:room]][:channel].push(message.to_json)
    else
      clients[ws][:rooms].each_value { |r| r[:channel].push((message || {}).to_json) }
    end
  end

  # исключение клиента из канала
  def leave(ws, clients, rooms, message)
    if clients.key?(ws)
      if !message.nil? && message.key?(:room)
        room = clients[ws][:rooms][message[:room]]
        room[:channel].unsubscribe(room[:sid])
        message(ws, clients, rooms, {:room => message[:room], :event => :leave})
      else
        clients[ws][:rooms].each do |n, r|
          r[:channel].unsubscribe(r[:sid])
          message(ws, clients, rooms, {:room => n, :event => :leave})
        end
        clients.delete(ws)
      end
    end
  end
end