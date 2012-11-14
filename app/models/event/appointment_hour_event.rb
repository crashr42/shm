class AppointmentHourEvent < Event
  has_many :appointment_events, :foreign_key => :event_id
  has_many :attending_doctor_attendees, :foreign_key => :event_id
  child_events :appointment_event, :predicted_time => 15.minutes
end
