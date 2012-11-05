class PatientUser < User
  belongs_to :doctor_user

  default_scope :joins => :roles
  default_scope where("roles.name = 'patient'")
  default_scope :readonly => false
end
