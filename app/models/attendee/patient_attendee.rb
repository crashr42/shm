class PatientAttendee < Attendee
  after_create :busy_event

  private
  def busy_event
    self.event.status = 'busy'
    self.event.save!
  end
end
