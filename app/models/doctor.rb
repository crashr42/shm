class Doctor < User
  default_scope :joins => :roles
  default_scope where("roles.name = 'doctor'")
  default_scope :readonly => false
end
