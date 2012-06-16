class Event < ActiveRecord::Base
  belongs_to :calendar
  has_many   :recurrence_rules

  attr_protected :created_at, :id, :updated_at
end
