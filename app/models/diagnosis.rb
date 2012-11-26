class Diagnosis < ActiveRecord::Base
  has_many :patient_users
  attr_protected :id, :created_at, :updated_at
end
