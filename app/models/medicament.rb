class Medicament < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :patient_to_medicamentss, :foreign_key => :medicaments_id
  has_many :user_patient_users, :class_name => 'User::PatientUser', :through => :patient_to_medicamentss

  def self.custom_find_by_name commercial_name
    Medicament.where('commercial_name ILIKE ?', "%#{commercial_name}%")
  end

end
