module Auditor
  extend ActiveSupport::Concern

  DEFAULT = [:create, :update, :destroy]

  # Рассылаем сообщения на wsserver при изменении какой-либо модели
  included do
    # Имя канала для класса
    def self.channel(event = nil)
      [self.base_class.name.underscore, event].keep_if(&:present?).join('.')
    end

    # Отослать сообщение для класса
    def self.push(message, event = nil, ch = nil)
      ::Notification::Broadcast.message(message, [ch || channel, event].keep_if(&:present?).join('.'))
    end

    # Имя канала для конкретного объекта
    def channel(event = nil)
      ["#{self.class.base_class.name.underscore}.#{self.id}", event].keep_if(&:present?).join('.')
    end

    # Отослать сообщение для определенного экземпляра
    def push(message, event = nil, ch = nil)
      ::Notification::Broadcast.message(message, [ch || channel, event].keep_if(&:present?).join('.'))
    end

    # При создании, обновлении или удалении будут отсылаться сообщения в соответствующие каналы
    def self.default_channels(*args)
      options = args.last
      if options.is_a?(Hash)
        raise 'allow define :except or :only option, but no together' if options.key?(:except) && options.key?(:only)
        if options.key?(:only)
          Array.wrap(options[:only]).each { |c| self.define_default_channel(c) }
        elsif options.key?(:except)
          (DEFAULT - Array.wrap(options[:except])).each { |c| self.define_default_channel(c) }
        else
          DEFAULT.each { |c| self.define_default_channel(c) }
        end
      end
    end

    def self.define_default_channel(event)
      raise "not allow callback :#{event}" unless DEFAULT.include?(event)
      send(:after_commit, :on => event) do |record|
        record.class.base_class.push(record, event)
        push(record, event)
      end
    end
  end
end

ActiveRecord::Base.send(:include, Auditor)