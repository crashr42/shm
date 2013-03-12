class DoctorUser < User
  has_many :patient_users
  belongs_to :specialty
  has_many :attending_doctor_attendees, :foreign_key => :user_id
  has_many :appointment_events, :through => :attending_doctor_attendees, :foreign_key => :user_id

  default_scope :joins => :roles
  default_scope where("roles.name = 'doctor'")
  default_scope :readonly => false

  def is_attending?
    appointment_events.where('events.status = ?', 'process').count != 0 ? true : false
  end

  def processing_appointment
    appointment_events.where('events.status = ?', 'process').select('events.id').first
  end

end
