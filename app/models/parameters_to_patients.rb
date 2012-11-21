class ParametersToPatients < ActiveRecord::Base
  belongs_to :patient_user
  belongs_to :parameter
  attr_protected :id, :created_at, :updated_at
end
