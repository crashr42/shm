class Event < ActiveRecord::Base
  belongs_to :calendar
  belongs_to :user
  has_many   :recurrence_rules

  attr_protected :created_at, :id, :updated_at

  validates_inclusion_of :category, :in => %w{appointment appointment_hour}

  def self.categories
    %w{appointment appointment_hour}
  end
end
