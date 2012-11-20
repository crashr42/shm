class Document::AppointmentDocumentInfo < ActiveRecord::Base
 belongs_to :appointment_document
 #attr_accessible :anamnesis, :appointment_result

 before_save :set_document_id

 private
 def set_document_id
  self.document_id = self.appointment_document.id
 end

 def save_info
  
 end
end
