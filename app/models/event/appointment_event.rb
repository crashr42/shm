class AppointmentEvent < Event
  belongs_to :appointment_hour_event, :foreign_key => :event_id
  has_many :attending_doctor_attendees, :foreign_key => :event_id
  has_many :doctor_attendees, :foreign_key => :event_id
  has_many :patient_attendees, :foreign_key => :event_id

  def attending_doctor
    self.appointment_hour_event.attending_doctor_attendees.first.user
  end

  def self.coming_free
    where('date_start > ?', DateTime.now).where(:status => 'free').order(:date_start).limit(5)
  end
end
