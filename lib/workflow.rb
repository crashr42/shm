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
          @flows[flow].each do |_, block|
            @record.instance_eval(&block) if @flows.key?(flow) && !@flows[flow].nil?
          end
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
    def flow(name, flow, &block)
      @flows[flow] ||= {}
      @flows[flow][name] = block
    end
  end

  class << self
    def workflows
      @__workflows ||= {}
    end

    def add(klass, name, fields, flow)
      self.workflows[klass] ||= {}
      fields.each do |f|
        self.workflows[klass][f] ||= {}
        self.workflows[klass][f][name] = flow
      end
    end
  end

  module ClassMethods
    def workflow(work, klass = self, &block)
      work = work.is_a?(Hash) ? work : {work => work}
      name = work.keys[0]
      fields = Array.wrap(work.values[0])

      Workflow.add(klass, name, fields, block)
    end
  end

  included do
    after_initialize do |record|
      executed_workflows = [
          (Workflow.workflows[self.class] || {}),
          (Workflow.workflows[self.class.superclass] || {})
      ]
      defined_fields = []
      executed_workflows.each do |execute|
        execute.each do |field, flows|
          flows.each do |name, block|
            unless record.workflows.include?("#{self.class.name.underscore}_#{field}_#{name}")
              record.workflows["#{self.class.name.underscore}_#{field}_#{name}"] = Flow.new(record, field, &block)
            end
          end
          unless defined_fields.include?(field)
            record.class_eval do
              define_method field do
                read_attribute(field).try(:to_sym)
              end
            end
            defined_fields << field
          end
        end
      end
    end

    def workflows
      @__workflows ||= {}
    end

    before_validation do |record|
      record.workflows.each_value { |w| w.valid? }
    end
  end
end