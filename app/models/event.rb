class Event < ActiveRecord::Base
  belongs_to :user
  has_many :recurrence_rules
  has_many :attendees
  has_many :documents

  before_create :register_organizer

  attr_protected :created_at, :id, :updated_at

  accepts_nested_attributes_for :attendees, :allow_destroy => true

  validates_inclusion_of :category, :in => %w(appointment appointment_hour)

  # ---
  # appointment - прием у врача
  # участники
  # - доктор
  # - пациент
  # ---
  # appointment_hour - приемный час у врача
  # участники
  # - доктор
  def self.categories
    %w(appointment appointment_hour)
  end

  private
  def register_organizer
    if User.current.present?
      self.user = User.current
    end
  end
end
