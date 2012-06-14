class Role < ActiveRecord::Base
  has_many :users_to_roleses, :class_name => 'UsersToRoles'
  has_many :users, :through => :users_to_roleses

  attr_protected :id, :created_at, :updated_at, :users_to_roleses
end
