class Cabinet::Manager::UserController < Cabinet::ManagerController

  layout 'cabinet/manager/layout'

  def index

  end

  def find
    @users = User.where('email like ?', "%#{params[:name]}%").limit(20)

    render :layout => false
  end

  def show
    @user = User.find params[:id]
  end
end
