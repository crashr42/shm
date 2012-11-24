# encoding=UTF-8
class Cabinet::Doctor::DocumentController < ApplicationController

  layout 'cabinet/doctor/layout'

  #Creating new document
  def create

    respond_to { |f|
      begin
        @appointment_document = AppointmentDocument.new(:event_id => params[:event_id])
        @appointment_document.appointment_document_info = AppointmentDocumentInfo.new params[:appointment_document_info]

        @appointment_document.save!

        flash[:notice] = "Document was succefly cretating"
        return redirect_to cabinet_doctor_document_path(@appointment_document.id)
      rescue Exception => exp
        flash[:error] = exp.message
        return redirect_to new_cabinet_doctor_document_path(event_id: params[:event_id])
      end
    }
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
