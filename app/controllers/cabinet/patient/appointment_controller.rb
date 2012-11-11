class Cabinet::Patient::AppointmentController < Cabinet::PatientController
  def new
  end

  def create
    @event = AppointmentEvent.find params[:id]

    respond_to do |f|
      if PatientAttendee.create({:user => current_user, :event => @event})
        f.html { redirect_to({:action => :show, :id => @event.id}, :notice => 'Appointment created.') }
      else
        f.html { redirect_to({:action => :new}, :error => 'Appointment not created.') }
      end
    end
  end

  def show
    @event = AppointmentEvent.find params[:id]
    render :json => @event
  end

  def find
    @id = params[:id] || 0
    @date = params[:date].present? ? Time.at(params[:date].to_i).to_date : DateTime.now.to_date
    @appointments = AppointmentEvent.joins(:attendees).where(:attendees => {:user_id => @id}).where('date(date_start) = ?', @date).where(:status => 'free')
  end
end
