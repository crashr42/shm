class Admin < User
  default_scope :joins => :roles
  default_scope where("roles.name = 'admin'")
  default_scope :readonly => false
end
