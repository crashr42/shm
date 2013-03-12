class Cabinet::Patient::AppointmentController < Cabinet::PatientController
  def index
  end

  def create
    @event = AppointmentEvent.find params[:id]

    respond_to do |f|
      if PatientAttendee.new({:user => current_user, :event => @event}).save
        f.html { redirect_to({:action => :show, :id => @event.id}, :notice => 'Appointment created.') }
      else
        f.html { redirect_to({:action => :index}, :error => 'Appointment not created.') }
      end
    end
  end

  def show
    @event = AppointmentEvent.find params[:id]
  end

  def find
    @doctor = DoctorUser.find(params[:id])
    @date = params[:date].present? ? Time.at(params[:date].to_i).to_date : DateTime.now.to_date
    @appointments = AppointmentEvent.
        joins(:attendees).
        where(:attendees => {:user_id => @doctor.id}).
        where('date(date_start) = ?', @date).
        where(:status => 'free')
  end
end
