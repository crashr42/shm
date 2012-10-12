class DoctorUser < User
  default_scope :joins => :roles
  default_scope where("roles.name = 'doctor'")
  default_scope :readonly => false

  def appointments_hours
    Event.joins(:attendees).where(:category => 'appointment_hour').where(:attendees => {:user_id => id, :role => 'attending_doctor'})
  end
end
