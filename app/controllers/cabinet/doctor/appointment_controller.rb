class Cabinet::Doctor::AppointmentController < Cabinet::DoctorController

  layout 'cabinet/doctor/layout'

  #get appointment index page (search and select patient)
  def index
    respond_to { |f|
      @appntEvents = DoctorUser.current.appointment_events.order("date_start DESC")

      f.json {
        render :json => @appntEvents.to_json
      }
      f.html {}
    }
  end

  def get_free_appointments_for
    @doctor_id = params[:id] == "me" ? User.current.id : params[:id]
    @appntEvents = DoctorUser.find(@doctor_id).appointment_events.where('events.status = \'free\'').order('events.date_start DESC')

    respond_to{|f|
      f.html { render :layout => false }
      f.json { render :json => @appntEvents.to_json }
    }
  end

  def confirm
    @appointment_id = params['apptId']
    @patientId = params['patId']

    @new_Attendee = PatientAttendee.new
    @new_Attendee.user_id=@patientId
    @new_Attendee.event_id=@appointment_id

    @new_Attendee.save!
    render :text => "Status of event has been changed. Now is #{@new_Attendee.event.status}"
  end

  #get form create appointments event
  def new
    @event = AppointmentEvent.new
  end

  def new_appointment
    respond_to do |f|
      f.html {
      }
    end
  end

  def get_patient_searching_form

  end

  #It return patients searching form for appointment setting
  def searching_form_for_appt_assig

  end

  #create new appontment
  def create
    @event = AppointmentEvent.new params[:appointment_event]

    raise 'Not @event object' if @event.nil?

    respond_to do |f|


      raise "There'nt patient_id" if params['patient_id'].blank?

      #Getting appointment which collision with new app-t
      app_nts_by_date_start = DoctorUser.current.appointment_events.where(:date_start => (@event.date_start)..(@event.date_end))
      app_nts_by_date_end = DoctorUser.current.appointment_events.where(:date_end => (@event.date_start)..(@event.date_end))

      if app_nts_by_date_end.count > 0 or app_nts_by_date_start.count > 0
        raise 'Incorrect appointment duration'
      end

      @event.user = DoctorUser.current
      @event.save!

      @at_doctor = AttendingDoctorAttendee.create({:user => DoctorUser.current, :event => @event})

      @at_patient = PatientAttendee.create({:user => PatientUser.find(params['patient_id']), :event => @event})

      @at_doctor.save
      @at_patient.save

      f.html do
        redirect_to :controller => 'cabinet/doctor/appointment', :action => 'index'
      end

      f.json do
        render text: 'The Appointment was created successfully', layout: false
      end
    end
  end

  #show appointment
  def show
    #Get appointment
    @a = AppointmentEvent.find_by_id(params[:id]) if params[:id].present?
    unless @a.present? then
      flash[:error] = 'Cannot appointment for this id'
      redirect_to cabinet_doctor_appointments_path()
    end
  end

  def start_appointment
    respond_to {|f|
      f.json{
        AppointmentEvent.find(params[:id]).start_appointment
        render text: "Appointment ##{params[:id]} is processing".to_json, layout: false
      }
    }
  end
end
