class Cabinet::Manager::EventController < Cabinet::ManagerController
  def index
    @event = Event.new
    @event.date_start = DateTime.now
    @event.date_end = DateTime.now + 1.month
    @event.summary = "Some summary"

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

  def new
    if request.post?
      event = Event.new params[:event]
      event.save!

      redirect_to :controller => :event, :action => :new
    end
  end

  def find
    @calendars = Calendar.where('name like ?', "%#{params[:name]}%").limit(10)

    render :layout => false
  end

  def show

  end
end
