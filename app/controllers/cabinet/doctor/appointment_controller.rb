class Cabinet::Doctor::AppointmentController < Cabinet::DoctorController

  layout 'cabinet/doctor/layout'

  #get appointment index page (search and select patient)
  def index
    respond_to { |f|
      #begin
      #  @me_attendees = DoctorUser.find(User.current.id).attendees.where(type: "DoctorAttendee")
      #  raise "Yo have no appointments" if @me_attendees.blank?
      #
      #  @appointments = @me_attendees.map { |a| a.event }
      #  f.html { return render 'cabinet/doctor/appointment/index' }
      #
      #rescue Exception => exp
      #  flash[:error] = exp.message
      #  f.html {
      #    return redirect_to cabinet_doctor_root_path() }
      #end

      @attendees = current_user.attending_doctor_attendees
      @attendees.map! { |a|
        event = a.event
        {
            date_start: event.date_start,
            date_end: event.date_end,
            description: event.description,
            summary: event.summary,
            duration: event.duration
        }

      }
      f.json {
        render :json => @attendees.to_json
      }
      f.html {}
    }
  end

  #get form create appointments event
  def new
    @event = AppointmentEvent.new
  end

  #create new appontment
  def create
    @event = AppointmentEvent.new params[:appointment_event]

    respond_to do |f|
      begin
        raise "There'nt doctor_id " if params['doctor_id'].blank?
        raise "There'nt patient_id" if params['patient_id'].blank?

        @event.save!

        @at_doctor = DoctorAttendee.new
        @at_doctor.user_id = params['doctor_id']
        @at_doctor.event_id = @event.id

        @at_patient = PatientAttendee.new
        @at_patient.user_id = params['patient_id']
        @at_patient.event_id = @event.id

        @at_doctor.save
        @at_patient.save

        f.html { redirect_to(cabinet_doctor_appointment_path(@event.id), :notice => 'Event created.') }
      rescue Exception => exp
        flash[:error] = exp.message
        f.html do
          redirect_to new_cabinet_doctor_appointment_path()
        end
      end

    end
  end

  #show appointment
  def show
    #Get appointment
    @a = AppointmentEvent.find_by_id(params[:id]) if params[:id].present?
    unless @a.present? then
      flash[:error] = "Cannot appointment for this id"
      redirect_to cabinet_doctor_appointments_path()
    end
  end
end
