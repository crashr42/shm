class ParametersToPatients < ActiveRecord::Base
  belongs_to :patient_user
  belongs_to :parameter
  attr_accessible :parameter, :parameter_id, :patient_user, :user_id
end
