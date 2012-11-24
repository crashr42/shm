class AppointmentDocument < Document
  has_one :appointment_document_info, foreign_key: "document_id", autosave: true
  #accepts_nested_attributes_for :appointment_document_info
  validates_associated :appointment_document_info
  #attr_accessible :appointment_document_info_attributes

  after_save :save_appointment_document_info

  private
  def save_appointment_document_info
    @new_appointment_document_info = self.appointment_document_info
    @new_appointment_document_info.document_id = self.id
    @new_appointment_document_info.save
  end
end
