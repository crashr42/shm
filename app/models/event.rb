class Event < ActiveRecord::Base
  belongs_to :user
  has_many :recurrence_rules
  has_many :attendees
  has_many :documents

  before_create :register_organizer

  attr_accessible :type, :date_start, :time_start, :date_end, :time_end, :summary, :description, :attendees_attributes

  accepts_nested_attributes_for :attendees, :allow_destroy => true

  def self.find_by_user_and_date user_id, start_date, end_date = nil
    if end_date.present?
      Event.joins(:attendees).
          where('attendees.user_id = ? or events.user_id = ?', user_id, user_id).
          where('date(date_start) >= ? or date(date_end) <= ?', start_date, end_date)
    else
      Event.joins(:attendees).
          where('attendees.user_id = ? or events.user_id = ?', user_id, user_id).
          where('date(date_start) >= ? or date(date_end) <= ?', start_date, start_date)
    end
  end

  private
  def register_organizer
    if User.current.present?
      self.user = User.current
    end
  end
end
