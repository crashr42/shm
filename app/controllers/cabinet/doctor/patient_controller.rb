class Cabinet::Doctor::PatientController < Cabinet::DoctorController
  def index
    @patients = current_user.patient_users
    respond_to do |f|
      f.html {} # нужно чтобы html страничку отдавало при прямом переходе
      f.json {
        render :json => @patients.to_json
      }
    end
  end

  def show
    @patient = PatientUser.find params[:id]
  end

  def new
    respond_to {|f|
      f.html{}
    }
  end
end
