class Event < ActiveRecord::Base
  # Организатор события
  belongs_to :user
  # Родительское событие/процесс
  belongs_to :event
  # Дочерние события
  has_many :events
  # Рекурентные правила
  has_many :recurrence_rules
  # Участники события
  has_many :attendees
  # Документы характеризующие события
  has_many :documents

  before_validation :register_organizer, :calculate_duration, :check_duration
  after_update :watch_status_changed

  attr_accessible :type, :date_start, :time_start, :date_end, :time_end, :summary, :description, :attendees_attributes
  accepts_nested_attributes_for :attendees, :allow_destroy => true
  accepts_nested_attributes_for :event

  validates :status, :inclusion => {:in => %w(free busy process close)}, :presence => true
  validates :date_end, :presence => true, :timeliness => {:type => :date, :on_or_after => :date_start}
  validates :date_start, :presence => true, :timeliness => {:type => :date, :on_or_before => :date_end}
  validates :type, :presence => true
  validates :summary, :presence => true
  validates :duration, :presence => true

  # Поиск событий, в которых пользователь участвует или которые он организует, за указанный промежуток времени
  def self.find_by_user_and_date user_id, start_date, end_date = nil
    if end_date.present?
      Event.joins(:attendees).
          where('attendees.user_id = ? or events.user_id = ?', user_id, user_id).
          where('date(date_start) >= ? or date(date_end) <= ?', start_date, end_date)
    else
      Event.joins(:attendees).
          where('attendees.user_id = ? or events.user_id = ?', user_id, user_id).
          where('date(date_start) >= ? or date(date_end) <= ?', start_date, start_date)
    end
  end

  # Статусы события
  # - free    - событие доступно для записи
  # - busy    - событие уже имеет подписчиков и занято
  # - process - событие в процессе
  # - close   - событие завершилось
  def self.statuses
    %w(free busy process close)
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
  def self.child_events processes, options = {}
    raise "Predicred time not passed!" unless options[:predicted_time].present?
    process_array(processes, options[:predicted_time]) if processes.is_a? Array
    process(processes.to_s.classify.constantize, options[:predicted_time]) if processes.is_a? Symbol
  end

  private
  # Закрываем событи для записи если у него исчерпано свободное время
  def check_duration
    self.status = 'busy' if self.duration == 0
  end

  def self.process_array processes, predicted_time
    processes.each { |p| process(p.to_s.classify.constantize, predicted_time) }
  end

  def self.process p, predicted_time
    after_create do |record|
      Range.new(record.date_start.to_i, record.date_end.to_i, true).step(predicted_time) do |new_time|
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
      self.user_id = User.current.id
    end
  end

  # Вычисляем продолжительность события
  def calculate_duration
    self.duration = self.date_end - self.date_start
  end

  # Отслеживаем изменение статуса события
  def watch_status_changed
    if self.status_changed?
      signal = "change_status_#{self.status_was}_to_#{self.status}"
      if self.respond_to? signal
        send(signal)
      end
    end
  end

  def change_status_free_to_busy
    self.event.duration = self.event.duration - self.time_end.to_i + self.time_start.to_i
    self.event.save!
  end

  def change_status_busy_to_free
    self.event.duration = self.event.duration + self.time_end.to_i - self.time_start.to_i
    self.event.save!
  end
end
