class AppointmentEvent < Event
  belongs_to :appointment_hour_event, :foreign_key => :event_id
end
