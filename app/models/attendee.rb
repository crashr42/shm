class Attendee < ActiveRecord::Base
  belongs_to :user
  belongs_to :event

  validates_inclusion_of :role, :in => %w{patient doctor attending_doctor}

  # ---
  # Роли участников приема
  # - patient           - пациент
  # - doctor            - доктор
  # - attending_doctor  - доктор осуществляющий прием
  def self.roles
    %w{patient doctor attending_doctor}
  end

  attr_protected :id, :created_at, :updated_at
end
