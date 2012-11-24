class AppointmentDocument < Document
  has_one :appointment_document_info, autosave: true
  #accepts_nested_attributes_for :appointment_document_info
  #validates_associated :appointment_document_info
  #attr_accessible :appointment_document_info_attributes


end
