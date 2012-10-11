class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates_inclusion_of :role, :in => %w{patient doctor attending_doctor}

  def self.roles
    %w{patient doctor attending_doctor}
  end

  attr_protected :id, :created_at, :updated_at
end
