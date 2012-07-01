class Cabinet::Manager::EventController < Cabinet::ManagerController
  def index
    @event = Event.new
    @event.date_start = DateTime.now
    @event.date_end = DateTime.now + 1.month
    @event.summary = "Tratata"

    @rule = RecurrenceRule.new
    @rule.frequency = :yearly
    @rule.count = 1
    @rule.event = @event

    @result = @event
    @result[:rules] = [@rule]
  end
end
