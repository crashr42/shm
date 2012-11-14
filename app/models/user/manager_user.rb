class ManagerUser < User
  default_scope :joins => :roles
  default_scope where("roles.name = 'manager'")
  default_scope :readonly => false
end
