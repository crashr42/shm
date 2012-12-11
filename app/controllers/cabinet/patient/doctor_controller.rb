class Cabinet::Patient::DoctorController < Cabinet::PatientController
  layout 'cabinet/patient/doctor
'
  skip_before_filter :_check_doctor_exists

  def index
    @doctors = DoctorUser.all
  end

  def create
    current_user.doctor_user = DoctorUser.find params[:id]
    current_user.save!
    respond_to do |f|
      f.html {redirect_to({:controller => :'cabinet/patient/index', :action => :index}, :notice => 'doctor_changed')}
    end
  end

  def show
    @doctor = DoctorUser.find params[:id]
  end

  def find
    render :json => DoctorUser.where('email like ?', "%#{params[:name]}%").limit(10)
  end
end
