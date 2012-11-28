class Specialty < ActiveRecord::Base
  has_many :doctor_users
  attr_accessible :name

  validates :name, :presence => true
end
