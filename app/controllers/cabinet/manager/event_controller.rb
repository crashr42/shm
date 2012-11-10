class Cabinet::Manager::EventController < Cabinet::ManagerController
  def index
    start_date = Time.at(params[:start].to_i).to_date
    end_date = Time.at(params[:end].to_i).to_date
    user_id = params[:id]

    respond_to do |f|
      f.html
      f.json {
        events = Event.find_by_user_and_date user_id, start_date, end_date
        render :json => events.map {|e|{
            id:    e.id,
            title: t("event.categories.#{e.type.underscore.gsub('_event', '')}"),
            start: e.datetime_start,
            end:   e.datetime_end
        }}
      }
    end
  end

  def new
    @event = Event.new
  end

  def create
    @event = params[:event][:type].constantize.new params[:event]

    respond_to do |f|
      if @event.save!
        f.html { redirect_to({:action => :show, :id => @event.id}, :notice => 'event_created') }
      else
        f.html { render :action => :new }
      end
    end
  end

  def find
    @calendars = Calendar.where('name like ?', "%#{params[:name]}%").limit(10)

    render :layout => false
  end

  def find_attendee
    @users = User.where('email like ?', "%#{params[:name]}%").limit(10)

    render :layout => false
  end

  def show
    @event = Event.find params[:id]

    respond_to do |format|
      format.html
      format.json { render :json => @event }
    end
  end
end
