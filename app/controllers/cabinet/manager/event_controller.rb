class Cabinet::Manager::EventController < Cabinet::ManagerController
  def index

  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new params[:event]

    respond_to do |f|
      if @event.save
        f.html { redirect_to({:action => :show}, :notice => 'Event created.') }
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
