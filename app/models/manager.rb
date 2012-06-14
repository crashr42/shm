class Manager < ActiveRecord::Base
  default_scope :joins => :roles
  default_scope where("roles.name = 'manager'")
end
