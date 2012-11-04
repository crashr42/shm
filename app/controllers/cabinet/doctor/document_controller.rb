class Cabinet::Doctor::DocumentController < ApplicationController
  
  layout 'cabinet/doctor/layout'

  #Show avalible event's
  def show_events
    @events = Event.where(:id => Attendee.select("event_id").where("user_id = ? AND role = ?", User.current.id, 'attending_doctor'))
  end

  #Get form for creating new document
  def new
    @event = Event.find_by_id params['event_id']
    if @event.blank?
      flash[:error] = "Event #{params['event_id']} was not found!"
      redirect_to '/cabinet/doctor/document/index'
    end
  end
  
  #Creting new document
  def create 
    
    begin
      if params[:event_id].blank?
        raise "No event_id in params"
      end

      if params[:doc_content].blank?
        raise "You must all field complete"
      end

      @document = Document.new
      @document.event_id = params[:event_id]
      @document.record = params[:doc_content]
      @document.user = User.current
      @document.save
      flash[:notice] = 'Document was succefly cretating'
      
    rescue Exception => exp
      flash[:error] = exp.message
      return redirect_to "/cabinet/doctor/document/new-for-event/#{params['event_id']}" if params[:event_id].present?
    end

    return redirect_to '/cabinet/doctor/document/index'
  end
end
