class Cabinet::Doctor::AppointmentController < ApplicationController
  
  layout 'cabinet/doctor/layout'
  
  #get appointment index page (earh and select patient)
  def index 
    @events = Event.all
    #@events = Event.where(:id => Attendee.select("event_id").where("user_id = ? AND role = ?", User.current.id, 'attending_doctor'))
  end 

  #get form create appointments event
  def new
   @event = Event.new
   @event.user_id = User.current.id
   @event.category = 'appointment'
  end

  #create new appontment
  def create
   @event = Event.new params[:event]

   respond_to do |f|
       begin
       @event.save

       @at_doctor = Attendee.new
       @at_doctor.user_id = params['doctor_id']
       @at_doctor.event_id = @event.id
       @at_doctor.role = 'doctor'
       @at_doctor.save

       @at_patient = Attendee.new
       @at_patient.user_id = params['patient_id']
       @at_patient.event_id = @event.id
       @at_patient.role = 'patient'
       @at_patient.save

       f.html { redirect_to({:action => :show, :id => @event.id}, :notice => 'Event created.')}
     rescue Exception => exp
        puts exp.message
        flash[:error] = exp.message
        f.html { render :action => :new }
     end

   end
  end

  #show appointment
  def show
   
  end
end
