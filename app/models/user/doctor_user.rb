class DoctorUser < User
  has_many :patient_users
  belongs_to :specialty

  default_scope :joins => :roles
  default_scope where("roles.name = 'doctor'")
  default_scope :readonly => false

end
