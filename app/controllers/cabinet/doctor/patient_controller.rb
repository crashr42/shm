class Cabinet::Doctor::PatientController < Cabinet::DoctorController
  def index
    @patients = current_user.patient_users
    respond_to do |f|
      f.json {
        render :json => @patients.to_json
      }
    end
  end

  def show
    @patient = PatientUser.find params[:id]
  end
end
