class DoctorUser < User
  has_many :patient_users

  default_scope :joins => :roles
  default_scope where("roles.name = 'doctor'")
  default_scope :readonly => false

  def appointments_hours
    AppointmentHourEvent.joins(:attendees).where(:attendees => {:user_id => id, :role => 'attending_doctor'})
  end
end
