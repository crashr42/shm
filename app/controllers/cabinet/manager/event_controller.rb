class Cabinet::Manager::EventController < Cabinet::ManagerController

  layout 'cabinet/manager/event'

  def index
    @event = Event.new
    @event.date_start = DateTime.now
    @event.date_end = DateTime.now + 1.month
    @event.summary = "Tratata"

    @rule = RecurrenceRule.new
    @rule.frequency = :weekly
    @rule.interval = 1
    @rule.count = 1
    @rule.event = @event
    @rule.seconds = [1, 2, 4]
    @rule.week_days = %w{1_1 2_3}

    @result = @event
    @result[:rules] = [@rule]
  end
end
