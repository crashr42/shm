class PatientToMedicaments < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :user_patient_user, :foreign_key => :users_id
  belongs_to :medicament, :foreign_key => :medicaments_id
end
