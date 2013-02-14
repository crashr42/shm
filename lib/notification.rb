module Notification
  class Broadcast
    def self.send(channel, message)
      sending_message = {
          :room => channel,
          :event => :message,
          :type => :parameter_data,
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