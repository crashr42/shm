class Cabinet::Patient::AppointmentController < Cabinet::PatientController
  def new
  end

  def create
    @event = AppointmentEvent.find params[:id]

    respond_to do |f|
      if PatientAttendee.create({:user => current_user, :event => @event})
        f.html { redirect_to({:action => :show}, :notice => 'Appointment created.') }
      else
        f.html { redirect_to({:action => :new}, :error => 'Appointment not created.') }
      end
    end
  end

  def show

  end
end
