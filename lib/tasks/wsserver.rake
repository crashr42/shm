task :wsserver => :environment do
  require 'em-websocket'

  SOCKETS = []

  url = URI.parse(Rails.application.config.wsserver)

  EventMachine.run do
    puts "Starting websocket server on #{Rails.application.config.wsserver}"
    # Creates a websocket server
    EventMachine::WebSocket.start(:host => url.host, :port => url.port) do |ws|
      ws.onopen do
        # When someone connects I want to add that socket to the SOCKETS array that
        puts "Socket connecting"
        SOCKETS << ws
      end

      ws.onmessage do |message|
        # Broadcast message
        puts "Brodcasting message: #{message}"
        SOCKETS.each { |s| s.send message }
      end

      ws.onclose do
        # Upon the close of the connection I remove it from my list of running sockets
        puts "Socket disconnectd"
        SOCKETS.delete ws
      end
    end
  end
end