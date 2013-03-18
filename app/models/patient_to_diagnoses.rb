class PatientToDiagnoses < ActiveRecord::Base
  #attr_accessible :diagnose_id, :user_id
  belongs_to :patient_user, :foreign_key => :user_id
  belongs_to :diagnosis, :foreign_key => :diagnosis_id
end
