task :wsserver => :environment do
  require 'em-websocket'
  require 'yajl'

  url = URI.parse(Rails.application.config.wsserver)

  EventMachine.run do
    @rooms = Hash.new { |h, k| h[k] = EventMachine::Channel.new }
    @handler = Handler.new
    @clients = Hash.new { |h, k| h[k] = {:rooms => {}} }

    # Создаем websocket сервер
    EventMachine::WebSocket.start(:host => url.host, :port => url.port) do |ws|
      ws.onopen do
        # Сохраняем клиента
        @clients[ws] = {:rooms => {}}
      end

      ws.onmessage do |message|
        begin
          # Получаем сообщение от клиента
          json_parser = Yajl::Parser.new(:symbolize_keys => true)
          decoded_message = json_parser.parse(message)
          # Получаем запрашиваемое действие
          event = decoded_message[:event]
          # Выполняем запрашиваемое действие
          @handler.send(event.to_sym, ws, @clients, @rooms, decoded_message)
        rescue => e
          ws.send({:event => :error, :message => e.message}.to_json)
        end
      end

      ws.onclose do
        # Когда клиент отключается, отсылаем сообщение по всем каналам в которых был зарегистрирован клиент
        @handler.leave(ws, @clients, @rooms, nil)
      end
    end

    puts "Websocket server started on #{Rails.application.config.wsserver}"
  end
end