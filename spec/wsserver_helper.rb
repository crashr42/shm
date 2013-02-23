class Channel
  def subscribe(&block)
    rand(899) + 100
  end

  def unsubscribe(sid) end

  def push(message) end
end

class WsSocket

end