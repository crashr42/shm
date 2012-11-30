class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates :user_id, :presence => true
  validates :event_id, :presence => true

  attr_protected :id, :created_at, :updated_at
end
