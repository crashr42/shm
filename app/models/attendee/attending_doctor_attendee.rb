class AttendingDoctorAttendee < Attendee
  after_create :add_attending_doctor_to_child

  private
  def add_attending_doctor_to_child
    if self.event.is_a? AppointmentHourEvent
      self.event.appointment_events.each do |e|
        AttendingDoctorAttendee.create({:user => self.user, :event => e})
      end
    end
  end
end
