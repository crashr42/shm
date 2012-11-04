class Cabinet::Doctor::AppointmentController < ApplicationController
  
  layout 'cabinet/doctor/layout'
  
  #get appointment index page (earh and select patient)
  def index 

  end 

  #get form create appointments event
  def new
   @event = Event.new
  end

  #create new appontment
  def create
   @event = Event.new params[:event]

   respond_to do |f|
     #if @event.save
      #  f.html { redirect_to({:action => :show, :id => @event.id}, :notice => 'Event created.') }
     #else
      #  f.html { render :action => :new }
     #end
     begin
       @event.save
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
