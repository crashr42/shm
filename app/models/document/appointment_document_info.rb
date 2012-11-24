class AppointmentDocumentInfo < ActiveRecord::Base
  belongs_to :appointment_document, :foreign_key => "document_id"
  attr_accessible :anamnesis, :appointment_result

  validates :anamnesis, :appointment_result, presence: true
  validates :anamnesis, length: {minimum: 15}
  validates :appointment_result, :length => {:minimum => 15}
end
