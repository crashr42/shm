class AttendingDoctorAttendee < Attendee
  after_create :add_attending_doctor_to_child

  belongs_to :doctor_user, :foreign_key => :user_id
  belongs_to :appointment_event, :foreign_key => :event_id

  private
  # При создании участника доктора, если событие к которому привязывается доктор - приемный час:
  # для всех дочерних событий выставляем доктора как принимаюшего доктора.
  def add_attending_doctor_to_child
    if self.event.is_a? AppointmentHourEvent
      self.event.appointment_events.each do |e|
        AttendingDoctorAttendee.create({:user => self.user, :event => e})
      end
    end
  end
end
