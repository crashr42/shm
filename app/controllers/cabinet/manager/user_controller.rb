class Cabinet::Manager::UserController < Cabinet::ManagerController

  layout 'cabinet/manager/layout'

  def index

  end

  def find
    @users = User.select([:id, :email]).where('email like ?', "%#{params[:name]}%").limit(200)

    respond_to do |f|
      f.html { render :layout => false }
      f.json { render :json => @users }
    end
  end

  def show
    @user = User.find params[:id]
  end
end
