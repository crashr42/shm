class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
  attr_protected :id, :created_at, :updated_at
end
