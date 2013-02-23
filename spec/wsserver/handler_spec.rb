require 'spec_helper'
require 'wsserver_helper'

describe Handler do
  before(:each) do
    @rooms = Hash.new { |h, k| h[k] = Channel.new }
    @clients = Hash.new { |h, k| h[k] = {:rooms => {}} }
    @handler = Handler.new
    @socket = WsSocket.new
  end

  it 'should join client to room and send message to room' do
    message = {
        :event => 'join',
        :room => 'test'
    }
    @handler.should_receive(:message).with(@socket, @clients, @rooms, message)
    @handler.send(message[:event].to_sym, @socket, @clients, @rooms, message)
    @clients.should have_key(@socket)
    @clients[@socket].should have_key(:rooms)
    @clients[@socket][:rooms].should have_key(message[:room])
    @clients[@socket][:rooms][message[:room]].should have_key(:channel)
    @clients[@socket][:rooms][message[:room]].should have_key(:sid)
    @clients[@socket][:rooms][message[:room]][:channel].should == @rooms[message[:room]]
  end

  it 'should send message to concrete room' do
    message = {
        :event => 'message',
        :room => 'test'
    }
    channel = Channel.new
    @clients[@socket][:rooms][message[:room]] = {
        :channel => channel,
        :sid => channel.subscribe
    }
    1.upto(10) do |n|
      fake_room = "fake_room_#{n}"
      fake_channel = Channel.new
      @clients[@socket][:rooms][fake_room] = {
          :channel => fake_channel,
          :sid => fake_channel.subscribe
      }
      fake_channel.should_not_receive(:push)
    end
    channel.should_receive(:push).with(message.to_json)
    @handler.send(message[:event], @socket, @clients, @rooms, message)
  end

  context 'should' do
    before(:each) do
      1.upto(10) do |n|
        fake_room = "fake_room_#{n}"
        fake_channel = Channel.new
        @clients[@socket][:rooms][fake_room] = {
            :channel => fake_channel,
            :sid => fake_channel.subscribe
        }
      end
    end

    context 'send broadcasting message' do
      before(:each) do
        @clients[@socket][:rooms].each_value { |f| f[:channel].should_receive(:push).with({}.to_json) }
      end

      it 'with nil message' do
        @handler.message(@socket, @clients, @rooms, nil)
      end

      it 'with message without room' do
        @handler.message(@socket, @clients, @rooms, {})
      end
    end

    it 'specify room and recieve message' do
      message = {
          :room => 'fake_room_1',
          :event => :leave
      }
      @clients[@socket][:rooms][message[:room]][:channel].should_receive(:push).with(message.to_json)
      @clients[@socket][:rooms].each { |n, f| f[:channel].should_not_receive(:push) unless n == message[:room] }
      @handler.leave(@socket, @clients, @rooms, message)
    end

    it 'all rooms and recieve message' do
      message = {
          :event => :leave
      }
      @clients[@socket][:rooms].each { |n, f| f[:channel].should_receive(:push).with({:room => n}.merge(message).to_json) }
      @handler.leave(@socket, @clients, @rooms, message)
    end
  end
end