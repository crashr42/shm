class Diagnosis < ActiveRecord::Base
  has_many :patient_users
  attr_accessible :class_code, :class_name, :block_code, :block_name, :code, :code_name

  validates :class_code, :presence => true
  validates :class_name, :presence => true
  validates :block_code, :presence => true
  validates :block_name, :presence => true
  validates :code_name, :presence => true
  validates :code, :presence => true
end
