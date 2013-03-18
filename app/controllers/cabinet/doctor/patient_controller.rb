class Cabinet::Doctor::PatientController < Cabinet::DoctorController
  layout 'cabinet/doctor/layout'

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
    respond_to { |f|
      f.html {}
    }
  end

  def all_diagnoses
    respond_to { |f|
      f.html {

      }

      f.json {
        render text: 'that is working', layout: false
      }
    }
  end

  def diagnoses_assigning
    @diagnoses = PatientUser.find(params[:id]).diagnosis
    respond_to { |f|
      f.html {}
    }
  end

  def find_diagnose
    respond_to { |f|
      f.html {
        @diagnoses = Diagnosis.custom_find_by_name(params[:name])
      }
    }

  end

  def confirm_diagnoses
    respond_to { |f|
      checkboxes = params[:item]

      diagnosis = PatientUser.find(params[:patient_id]).diagnosis

      if diagnosis.count > 0
        diagnosis.each { |diagnose|
          if checkboxes.present? && checkboxes.include?(diagnose.id)
            #If patient stay still with this diagnose
            checkboxes.reject! { |chbx| chbx == diagnose.id }
          else
            #If doctor unchecked this diagnose
            deleted = PatientToDiagnoses.where('user_id = ? AND diagnosis_id = ?', params[:patient_id], diagnose.id).first
            deleted.delete
          end
        }
      end

      if checkboxes.present?
        checkboxes.each { |i|
          new_patient_to_diagnose = PatientToDiagnoses.new
          new_patient_to_diagnose.user_id = params[:patient_id]
          new_patient_to_diagnose.diagnosis_id = i

          new_patient_to_diagnose.save
        }
      end

      f.html {}
      f.json {
        render text: 'Diagnoses successfully updated', layout: false
      }
    }
  end
end
