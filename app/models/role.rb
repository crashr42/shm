class Role < ActiveRecord::Base
  has_and_belongs_to_many :users

  attr_protected :id, :creaated_at, :updated_at
end
