class Document::AppointmentDocument < Document
 has_one :appointment_document_info 
 
 before_save :save_info
 
 anamnesis

 private
 def save_info
   
 end
end
