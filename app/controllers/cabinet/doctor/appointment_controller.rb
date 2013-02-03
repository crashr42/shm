class Cabinet::Doctor::AppointmentController < Cabinet::DoctorController

  layout 'cabinet/doctor/layout'

  #get appointment index page (search and select patient)
  def index
    respond_to { |f|
      @attendees = current_user.attending_doctor_attendees

      #Формируем ответ для отрисовки в браузере
      @attendees.map! { |a|
        event = a.event
        {
          id: event.id,
          date_start: event.date_start,
          date_end: event.date_end,
          description: event.description,
          summary: event.summary,
          duration: event.duration,
          status: event.status,
          type: event.type
        }
      }

      #А тепеь исключим лишние элементы.
      #Здесь я делаю исключение после формирования ответа. Это необходимо, так как если исключать до формирования
      #,то будет происходить больше запросов к БД.
      @attendees.reject! {|a|
        not (a[:type] == 'AppointmentEvent')
      }

      f.json {
        render :json => @attendees.to_json
      }
      f.html {}
    }
  end

  def get_appointments_for
    @attendees = DoctorUser.find(params[:id]).attending_doctor_attendees

    #Формируем ответ для отрисовки в браузере
    @attendees.map! { |a|
      event = a.event
      {
          id: event.id,
          date_start: event.date_start,
          date_end: event.date_end,
          description: event.description,
          summary: event.summary,
          duration: event.duration,
          status: event.status,
          type: event.type
      }
    }

    #А тепеь исключим лишние элементы.
    #Здесь я делаю исключение после формирования ответа. Это необходимо, так как если исключать до формирования
    #,то будет происходить больше запросов к БД.
    @attendees.reject! {|a|
      not (a[:type] == 'AppointmentEvent')
    }

    respond_to{|f|
      f.html { render :layout => false }
      f.json { render :json => @attendees.to_json }
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
