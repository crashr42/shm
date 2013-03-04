module Workflow
  extend ActiveSupport::Concern

  # Хараетеризует возможные переходы для какого-либо поля объекта
  class Flow
    def initialize(record, field, &block)
      @record = record
      @field = field.to_sym
      @flows = {}

      instance_eval(&block)
    end

    # Вызывает переход объекта из одного состояни в другое после смены значения поля
    def transition
      if field_changed?
        if @flows.select { |flow, _| flow.is_a?(Hash) && flow.key?(old_value) && flow[old_value] == new_value }.empty?
          @record.errors.add(@field, "#{@field}.cannot_be_change.from.#{old_value}.to.#{new_value}")
        else
          flow = {old_value => new_value}
          @record.instance_eval(&@flows[flow]) if @flows.key?(flow) && !@flows[flow].nil?
        end
      end
    end

    # Старое значение поля
    def old_value
      @record.send("#{@field}_was").nil? ? nil : @record.send("#{@field}_was").to_sym
    end

    # Новое значение поля
    def new_value
      @record.send(@field).nil? ? nil : @record.send(@field).to_sym
    end

    # Меняло ли поле значение?
    def field_changed?
      @record.send("#{@field}_changed?")
    end

    # Проверяет корректность смены значения поля
    def valid?
      transition if !@record.new_record? && !old_value.nil?
    end

    # Добавляет возможный переход для значения
    def flow(flow, &block)
      @flows[flow] = block
    end
  end

  module ClassMethods
    def workflow(field, &block)
      workflows[field] = block
    end

    def workflows
      @__workflows ||= {}
    end
  end

  included do
    after_initialize do |record|
      self.class.workflows.each do |field, block|
        record.workflows[field] = Flow.new(record, field, &block)

        record.class_eval do
          attr_accessor field

          define_method field do
            read_attribute(field).present? ? read_attribute(field).to_sym : read_attribute(field)
          end

          define_method :"#{field}=" do |value|
            write_attribute(field, value)
          end
        end
      end
    end

    def work(flow, work)
      self.workflows[flow].work(work)
    end

    def workflows
      @__workflows ||= {}
    end

    before_validation do |record|
      record.workflows.each_value { |w| w.valid? }
    end
  end
end