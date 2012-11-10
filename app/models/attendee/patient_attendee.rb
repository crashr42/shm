class PatientAttendee < Attendee
  after_create :busy_event

  private
  # При создании участника пациента помечаем событие в котором он учавствует как занятое
  def busy_event
    self.event.status = 'busy'
    self.event.save!
  end
end
