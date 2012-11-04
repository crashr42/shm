class Cabinet::Doctor::UserController < ApplicationController
  
  #find user by name
  def find
    @users = User.select([:id, :email]).where('email like ?', "%#{params[:name]}%").limit(200)

    respond_to do |f|
      f.html { render :layout => false }
      f.json { render :json => @users }
    end
  end

end
