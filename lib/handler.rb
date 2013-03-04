class Handler
  # Присоединение клиента к какому-либо каналу
  def join(socket, clients, rooms, message)
    unless clients[socket][:rooms].key?(message[:room])
      clients[socket][:rooms][message[:room]] = {
          :channel => rooms[message[:room]],
          :sid => rooms[message[:room]].subscribe { |msg| socket.send msg }
      }
      message(socket, clients, rooms, message)
    end
  end

  # отправка сообщения
  def message(socket, clients, rooms, message)
    if room_message?(message)
      rooms[message[:room]].push(message.to_json)
    else
      clients.each_key { |s| s.send(message.to_json) }
    end
  end

  # исключение клиента из канала
  def leave(socket, clients, rooms, message)
    if clients.key?(socket)
      if room_message?(message)
        room = clients[socket][:rooms][message[:room]]
        room[:channel].unsubscribe(room[:sid])
        message(socket, clients, rooms, {:room => message[:room], :event => :leave})
      else
        clients[socket][:rooms].each do |room_name, room|
          room[:channel].unsubscribe(room[:sid])
          message(socket, clients, rooms, {:room => room_name, :event => :leave})
        end
        clients.delete(socket)
      end
    end
  end

  private
  def room_message?(message)
    !message.nil? && message.key?(:room) && message[:room] != 'all'
  end
end