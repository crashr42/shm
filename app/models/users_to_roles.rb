class UsersToRoles < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  attr_protected :id, :created_at, :updated_at
end
