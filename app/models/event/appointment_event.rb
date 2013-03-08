class AppointmentEvent < Event
  belongs_to :appointment_hour_event, :foreign_key => :event_id

  has_many :attending_doctor_attendees, :foreign_key => :event_id
  has_many :doctor_attendees, :foreign_key => :event_id
  has_many :patient_attendees, :foreign_key => :event_id

  has_many :doctor_user, :through => :attending_doctor_attendees, :foreign_key => :event_id

  def attending_doctor
    self.appointment_hour_event.attending_doctor_attendees.first.user
  end

  def self.coming_free
    where('date_start > ?', DateTime.now).where(:status => 'free').order(:date_start).limit(5)
  end

  def unsubsribe id
    u = User.find id
    a = self.patient_attendees.where(:user_id => u.id).first
    a.destroy.destroyed? ? EventMailer::unsubscribe(self, u).deliver : false
  end

  def start_appointment
    raise 'You have one appointment processing already' if DoctorUser.current.is_attending?
    if self.status == :busy
      self.status= :process
      save
    else
      raise 'Cannot start appointment with different status from busy'
    end
  end

  def finish_appointment
    if self.status == :process
      self.status= :close
      save
    else
      raise 'Cannot stop appointment with different status from process'
    end
  end

  def is_processing?
    self.status == 'process' ? true : false
  end
end
