class Cabinet::Doctor::AppointmentController < ApplicationController
  
  #get appointment index page (earh and select patient)
  def index 

  end 

  #get form create appointments event
  def new
   @event = Event.new
  end

  #create new appontment
  def create
   
  end
end
