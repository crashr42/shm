class Calendar < ActiveRecord::Base
  belongs_to :user
  has_many   :events

  attr_protected :created_at, :id, :updated_at
end
