module Auditor
  extend ActiveSupport::Concern

  # Рассылаем сообщения на wsserver при изменении какой-либо модели
  included do
    # Имя канала для класса
    def self.channel
      self.name.underscore
    end

    # Имя канала для конкретного объекта
    def channel
      "#{self.class.name.underscore}_#{self.id}"
    end

    [:after_save, :after_create, :after_update, :after_destroy].each do |cb|
      send(cb) do |record|
        ::Notification::Broadcast.send(record, record.class.channel, cb.to_s.gsub(/after_/, '').to_sym)
        ::Notification::Broadcast.send(record, record.channel, cb.to_s.gsub(/after_/, '').to_sym)

        unless record.class.superclass == ActiveRecord::Base
          ::Notification::Broadcast.send(record, record.class.superclass.channel, cb.to_s.gsub(/after_/, '').to_sym)
        end
      end
    end
  end
end

ActiveRecord::Base.send(:include, Auditor)