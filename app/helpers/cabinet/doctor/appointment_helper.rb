module Cabinet::Doctor::AppointmentHelper
  def get_patient_by_event (event)
    @patient = PatientAttendee.find_by_event_id(event.id)
    @patient = @patient.present? ? @patient.user.get_FI : "Not found patient attendee"
  end
end
