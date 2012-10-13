class Cabinet::Manager::EventController < Cabinet::ManagerController
  def index

  end

  def new
    if request.post?
      event = Event.new params[:event]
      event.save!

      redirect_to :controller => :event, :action => :show, :id => event.id
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
