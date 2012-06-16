class Calendar < ActiveRecord::Base
  belongs_to :user
  has_many   :events

  attr_accessible :description, :name
end
