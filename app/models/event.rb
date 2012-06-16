class Event < ActiveRecord::Base
  belongs_to :calendar
  has_many   :recurrence_rules
end
