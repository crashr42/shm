class Cabinet::Manager::CalendarController < Cabinet::ManagerController
  layout 'cabinet/manager/layout'

  def index
  end

  def show
    @user = User.find params[:id]
    gon.id = params[:id]
  end
end
