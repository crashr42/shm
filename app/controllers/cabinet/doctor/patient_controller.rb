class Cabinet::Doctor::PatientController < Cabinet::DoctorController
  def index
    @patients = current_user.patient_users
  end

  def show
    @patient = PatientUser.find params[:id]
  end
end
