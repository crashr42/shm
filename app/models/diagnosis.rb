class Diagnosis < ActiveRecord::Base
  has_many :patient_to_diagnosesess, :foreign_key => :diagnosis_id
  has_many :user_patient_users, :through => :patient_to_diagnosesess, :foreign_key => :user_id
  attr_accessible :class_code, :class_name, :block_code, :block_name, :code, :code_name

  validates :class_code, :presence => true
  validates :class_name, :presence => true
  validates :block_code, :presence => true
  validates :block_name, :presence => true
  validates :code_name, :presence => true
  validates :code, :presence => true

  def self.custom_find_by_name diagnose_name
    Diagnosis.where('code_name ILIKE ?', "%#{diagnose_name}%")
  end
end
