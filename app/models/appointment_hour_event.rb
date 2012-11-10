class AppointmentHourEvent < Event
  has_many :appointment_events
  watch_events :appointment_event, :predicted_time => 15.minutes
end
