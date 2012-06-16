class Event < ActiveRecord::Base
  belongs_to :calendar
  has_many   :recurrence_rules

  attr_accessible :date_start, :description, :status, :summary
end
