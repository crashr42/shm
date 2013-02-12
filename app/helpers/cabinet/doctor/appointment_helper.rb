module Cabinet::Doctor::AppointmentHelper

  def get_patient_by_event (event)
    @patient = PatientAttendee.find_by_event_id(event.id)
    @patient.present? ? @patient.user.shortname : "Not found patient attendee"
  end

  def get_appointment_organizer(appointment)
   appointment.user_id.present? ? User.find(@a.user_id).shortname() : "Not found event organizer"
  end
end
