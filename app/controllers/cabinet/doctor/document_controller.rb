class Cabinet::Doctor::DocumentController < ApplicationController

  layout 'cabinet/doctor/layout'

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
      @document.save!
      flash[:notice] = "Document was succefly cretating"
      result = true

    rescue Exception => exp
      result = false
      flash[:error] = exp.message
    end

    respond_to do |f|
      f.html do
        #if there are exceprtion redirect to back        
        if result then
          return redirect_to cabinet_doctor_document_path(@document.id)
        else
          return redirect_to new_cabinet_doctor_document_path(event_id: params[:event_id])
        end #unless
      end
    end

  end

  #
  #Here we introduce the default action for the Rails resource
  #create, new, edit, show, update, destroy
  #

  def index
  end

  #Get form for creating new document
  def new
    @adoc = AppointmentDocument.new(event_id: params[:event_id])
    @adoc.appointment_document_info = AppointmentDocumentInfo.new
  end

  def edit
  end

  def show

    #Get the document by id
    @doc = Document.where("id = ? AND user_id = ?", params[:id], User.current.id).first()

    respond_to do |f|
      f.html do
        unless @doc.present? then
          flash[:error] = "requst document was not found or your  access denied"
          redirect_to cabinet_doctor_documents_path()
        end
      end
    end
  end

  def update
  end

  def destroy
  end

end
