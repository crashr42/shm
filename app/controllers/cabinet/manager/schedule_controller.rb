class Cabinet::Manager::ScheduleController < Cabinet::ManagerController
  def index
    @doctor = DoctorUser.find params[:id]
  end
end
