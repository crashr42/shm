class Cabinet::Doctor::DocumentController < ApplicationController
  
  layout 'cabinet/doctor/layout'

  #Show avalible event's
  def show_events

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
    if params[:event_id].blank?
      flash[:error] = "No event_id in params"
      #return redirect_to '/cabinet/doctor/document/index'
    end

    if params[:doc_content].blank?
      flash[:error] = "You must all field complete"
      #return redirect_to '/cabinet/doctor/document/index'
    end


    begin
      @document = Document.new
      @document.event_id = params[:event_id]
      @document.record = params[:doc_content]
      @document.user = User.current
      @document.save
      flash[:notice] = 'Document was succefly cretating'
      #return redirect_to '/cabinet/doctor/document/index'
    rescue
      flash[:error] = "Errror - can't create document"
    end

    return redirect_to '/cabinet/doctor/document/index'
  end
end
