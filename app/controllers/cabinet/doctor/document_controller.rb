class Cabinet::Doctor::DocumentController < ApplicationController
  
  layout 'cabinet/doctor/layout'

  #Show avalible event's
  def show_events

  end

  #Get form for creating new document
  def new

  end
  
  #Creting new document
  def create 
    begin
      @document = Document.new
      @document.event_id = @_params[:event_id]
      @document.record = @_params[:doc_content]
      @document.user = User.current
      @document.save
      flash[:notice] = 'Document was succefly cretating'
    rescue
      flash[:error] = "Errror - can't create document"
    end

    redirect_to :controller => "index", :action => :index
  end
end
