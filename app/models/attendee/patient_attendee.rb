class PatientAttendee < Attendee
  # Пациент-участник
  belongs_to :patient_user, :foreign_key => :user_id
  # Событие-прием
  belongs_to :appointment_event, :foreign_key => :event_id

  after_create :busy_event

  private
  # При создании участника пациента помечаем событие в котором он учавствует как занятое
  def busy_event
    self.event.status = 'busy'
    self.event.save!
  end
end
