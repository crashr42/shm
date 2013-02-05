task :wsserver => :environment do
  require 'em-websocket'

  url = URI.parse(Rails.application.config.wsserver)

  EventMachine.run do
    @channel = EventMachine::Channel.new

    # Creates a websocket server
    EventMachine::WebSocket.start(:host => url.host, :port => url.port) do |ws|
      ws.onopen do
        # When someone connects I want to add that socket to the SOCKETS array that
        puts "Socket connecting"
        @sid = @channel.subscribe { |msg| ws.send msg }
      end

      ws.onmessage do |message|
        # Broadcast message
        puts "Brodcasting message: #{message}"
        @channel.push message
      end

      ws.onclose do
        # Upon the close of the connection I remove it from my list of running sockets
        puts "Socket disconnectd"
        @channel.unsubscribe(@sid)
      end
    end

    puts "Websocket server started on #{Rails.application.config.wsserver}"
  end
end