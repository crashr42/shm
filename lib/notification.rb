module Notification
  class Broadcast
    # Отправка сообщения на wsserver
    # Доступные event => [:message, :join, :leave] см. класс lib/handler.rb
    def self.send(message, channel = :all, event = :message)
      sending_message = {
          :room => channel,
          :event => event,
          :data => message
      }.to_json

      # Check the reactor already running
      if EM.reactor_running?
        self.sender(sending_message, false)
      else
        EM.run { self.sender(sending_message, true) }
      end
    end

    private
    def self.sender(message, require_stop)
      conn = EventMachine::WebSocketClient.connect(::Rails.application.config.wsserver)

      # Sending message
      conn.callback do
        conn.send_msg message
      end

      # Handle errors
      conn.errback do |e|
        puts e
        conn.close_connection
      end

      # Close connection to websocket server
      conn.stream do
        conn.close_connection
      end

      # Stop reactor after disconnect
      conn.disconnect do
        EM::stop_event_loop if require_stop
      end
    end
  end
end