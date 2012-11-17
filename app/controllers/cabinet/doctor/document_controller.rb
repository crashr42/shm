class Cabinet::Doctor::DocumentController < ApplicationController
  
  layout 'cabinet/doctor/layout'

  #Show avalible event's
  def show_events
    @events = Event.where(:id => Attendee.select("event_id").where("user_id = ? AND role = ?", User.current.id, 'attending_doctor'))
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
      return redirect_to new_cabinet_doctor_document_path(event_id: params[:event_id]) if params[:event_id].present?
    end

    return redirect_to cabinet_doctor_documents_path()
  end

  #
  #Here we introduce the default action for the Rails resource
  #create, new, edit, show, update, destroy
  #

  def index
  end

  #Get form for creating new document
  def new
   @event = Event.find_by_id(params[:event_id]) 
  end
  
  def edit
  end

  def show
  end

  def update
  end

  def destroy
  end

end
