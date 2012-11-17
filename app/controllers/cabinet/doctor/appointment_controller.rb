class Cabinet::Doctor::AppointmentController < ApplicationController

  layout 'cabinet/doctor/layout'

  #get appointment index page (earh and select patient)
  def index

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
        @event.event_id = @event.id
        @event.save!

        @at_doctor = DoctorAttendee.new
        @at_doctor.user_id = params['doctor_id']
        @at_doctor.event_id = @event.event_id

        @at_patient = PatientAttendee.new
        @at_patient.user_id = params['patient_id']
        @at_patient.event_id = @event.event_id

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

  end
end
