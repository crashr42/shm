class Specialty < ActiveRecord::Base
  has_many :doctor_users
  attr_accessible :name
end
