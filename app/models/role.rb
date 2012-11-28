class Role < ActiveRecord::Base
  has_many :users_to_roleses, :class_name => 'UsersToRoles'
  has_many :users, :through => :users_to_roleses, :readonly => false

  validates :name, :presence => true

  attr_accessible :name
end
