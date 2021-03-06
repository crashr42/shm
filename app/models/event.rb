# encoding: UTF-8
class Event < ActiveRecord::Base
  include Workflow

  # Организатор события
  belongs_to :user
  # Родительское событие/процесс
  belongs_to :event, :autosave => true
  # Дочерние события
  has_many :events, :autosave => true
  # Рекурентные правила
  has_many :recurrence_rules
  # Участники события
  has_many :attendees
  # Документы характеризующие события
  has_many :documents

  before_validation :calculate_duration, :watch_duration_changed
  before_create :register_organizer
  after_initialize :default_values, :if => :new_record?

  attr_accessible :type, :date_start, :time_start, :date_end, :time_end, :summary, :description, :attendees_attributes
  accepts_nested_attributes_for :attendees, :allow_destroy => true
  accepts_nested_attributes_for :event

  validates :status, :inclusion => {:in => [:free, :busy, :process, :close]}, :presence => true
  validates :date_end, :presence => true, :timeliness => {:type => :date, :on_or_after => :date_start}
  validates :date_start, :presence => true, :timeliness => {:type => :date, :on_or_before => :date_end}
  validates :type, :presence => true
  validates :summary, :presence => true
  validates :duration, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  validate  :validate_duration

  # Поиск событий, в которых пользователь участвует или которые он организует, за указанный промежуток времени
  def self.find_by_user_and_date user_id, start_date, end_date = nil
    if end_date.present?
      Event.joins(:attendees).
          where('attendees.user_id = ? or events.user_id = ?', user_id, user_id).
          where('date(date_start) >= ? or date(date_end) <= ?', start_date, end_date).uniq
    else
      Event.joins(:attendees).
          where('attendees.user_id = ? or events.user_id = ?', user_id, user_id).
          where('date(date_start) >= ? or date(date_end) <= ?', start_date, start_date).uniq
    end
  end

  # Статусы события
  # - free    - событие доступно для записи
  # - busy    - событие уже имеет подписчиков и занято
  # - process - событие в процессе
  # - close   - событие завершилось
  def self.statuses
    [:free, :busy, :process, :close]
  end

  # Указывает что данный тип событий имеет дочерние события события.
  # === Examples
  # class AppointmentHourEvent < Event
  #   has_many :appointment_events
  #   child_events :appointment_event, :predicted_time => 15.minutes
  # end
  # Для событий типа AppointmentHourEvent при создании будут созданые дочерние события типа AppointmentEvent.
  # Даты начала и окончания дочерних событий будут совпадать с датами родительского события.
  # Времена начала и окончания дочерних событий будут увеличиваться на :predicted_time.
  # === Arguments
  # [processes]
  #   Типы дочерних событий.
  # [:predicted_time]
  #   Временной промежуток для дочернего события.
  # Arguments examples:
  #   child_events :some_child_event, :predicted_time => 15.minutes
  #   child_events [:some_child_event_class, :other_child_event_class], :predicted_time => 15.minutes
  def self.child_events(processes, options = {})
    raise 'Predicred time not passed!' unless options[:predicted_time].present?
    process_array(processes, options[:predicted_time]) if processes.is_a? Array
    process(processes.to_s.classify.constantize, options[:predicted_time]) if processes.is_a? Symbol
  end

  # Позволяет пользователю отписаться от события (выйти из списка участников).
  # === Examples
  # @event = Event.find params[:id]
  # respond_to do |f|
  #   if @event.unsubscribe current_user.id
  #     f.json {:message => 'unsubscribe'}
  #   else
  #     f.json {:message => 'error'}
  #   end
  # end
  # === Arguments
  # [id]
  #   Идентификатор пользователя которого нужно отписать от события.
  # Результатом метода должно быть булевое значение.
  def unsubsribe(id)
    false
  end

  def status_to_css
    {
        :free => 'badge badge-success',
        :busy => 'badge badge-important',
        :process => 'badge badge-info',
        :close => 'badge'
    }[self.status]
  end

  def duration_to_text
    hour = duration < 3600 ? 0 : duration / 3600
    min = duration < 60 ? 0 : duration / 60
    sec = duration - (min * 60 + hour*3600)
    "#{hour} ч #{min} мин #{sec} сек"
  end

  private
  def default_values
    self.status ||= :free
    self.type ||= 'Event'
  end

  def validate_duration
    if self.status == :free && self.duration.to_i == 0
      self.errors.add(:duaration, 'duration.must_be.greater_than.0')
    end
    if [:busy, :process, :close].include?(self.status) && self.duration.to_i > 0
      self.errors.add(:status, 'duration.must_be.equal_to.0')
    end
  end

  # Закрываем событие для записи если у него исчерпано свободное время
  def watch_duration_changed
    unless self.status_changed? && self.new_record?
      if self.duration_changed?
        if self.duration.to_i == 0
          self.status = :busy
        else
          self.status = :free
        end
      end
    end
  end

  def self.process_array(processes, predicted_time)
    processes.each { |p| process(p.to_s.classify.constantize, predicted_time) }
  end

  def self.process(p, predicted_time)
    after_create do
      Range.new(self.date_start.to_i, self.date_end.to_i, true).step(predicted_time) do |new_time|
        e = p.new
        e.date_start = Time.at(new_time).to_datetime
        e.date_end = (Time.at(new_time) + predicted_time).to_datetime
        e.summary = 'Free appointment'
        e.event = self
        e.user = ManagerUser.first
        e.save!
      end
    end
  end

  # Организатор события - текущий авторизованный пользователь
  def register_organizer
    if User.current.present?
      self.user_id ||= User.current.id
    end
  end

  # Вычисляем продолжительность события
  def calculate_duration
    if self.new_record?
      if self.status == :free
        self.duration = self.date_end - self.date_start
      else
        self.duration = 0
      end
    end
  end

  # Возможные переходы для статуса события
  workflow :status do
    flow :default, :busy => :process
    flow :default, :process => :close

    flow :reset_duration, :free => :busy do
      if self.event.present?
        self.event.duration -= self.date_end - self.date_start
      end
      self.duration = 0
    end

    flow :reset_duration, :busy => :free do
      if self.event.present?
        self.event.duration += self.date_end - self.date_start
      end
      self.duration = self.date_end - self.date_start
    end
  end
end
