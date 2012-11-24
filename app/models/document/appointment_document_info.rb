class AppointmentDocumentInfo < ActiveRecord::Base
  belongs_to :appointment_document, :foreign_key => "document_id"
  attr_accessible :anamnesis, :appointment_result

end
