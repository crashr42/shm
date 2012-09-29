class RecurrenceRule < ActiveRecord::Base
  belongs_to :event

  attr_protected :created_at, :updated_at, :id

  validates_inclusion_of :frequency, :in => %w{yearly monthly weekly daily hourly}

  def self.frequencies
    %w{yearly monthly weekly daily hourly}
  end

end
