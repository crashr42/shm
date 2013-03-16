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

  def all_diagnoses
    respond_to {|f|
      f.html{

      }

      f.json{
        render text: 'that is working', layout: false
      }
    }
  end

  def diagnoses_assigning
    respond_to {|f|
      f.html{}
    }
  end

  def find_diagnose

  end
end
