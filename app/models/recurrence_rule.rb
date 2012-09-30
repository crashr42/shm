class RecurrenceRule < ActiveRecord::Base
  belongs_to :event

  attr_protected :created_at, :updated_at, :id

  validates_inclusion_of :frequency, :in => [:yearly, :monthly, :weekly, :daily, :hourly]
  validates_numericality_of :count, :greater_than_or_equal_to => 0, :allow_blank => true, :allow_nil => true
  validates_numericality_of :hours, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 23, :allow_blank => true, :allow_nil => true
  validates_numericality_of :interval, :greater_than_or_equal_to => 1
  validates_numericality_of :minutes, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 59, :allow_nil => true, :allow_blank => true
  validates_numericality_of :month_days, :greater_than_or_equal_to => -31, :less_than_or_equal_to => 31, :allow_blank => true, :allow_nil => true
  validates_numericality_of :months, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 12, :allow_nil => true, :allow_blank => true
  validates_numericality_of :week_days, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6, :allow_blank => true, :allow_nil => true
  validates_numericality_of :week_start, :greater_than_or_equal_to => 0, :less_than_or_equal_to => 6
  validates_numericality_of :weeks, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 53, :allow_nil => true, :allow_blank => true
  validates_numericality_of :year_days, :greater_than_or_equal_to => 1, :less_than_or_equal_to => 366, :allow_nil => true, :allow_blank => true

  def self.frequencies
    [:yearly, :monthly, :weekly, :daily, :hourly]
  end
end
