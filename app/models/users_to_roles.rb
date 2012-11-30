class UsersToRoles < ActiveRecord::Base
  belongs_to :user
  belongs_to :role

  attr_accessible :user, :user_id, :role, :role_id
end
