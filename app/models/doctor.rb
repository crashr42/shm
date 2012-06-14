class Doctor < ActiveRecord::Base
  default_scope :joins => :roles
  default_scope where("roles.name = 'doctor'")
end
