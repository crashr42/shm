class Cabinet::Doctor::UserController < ApplicationController
  
  #find user by name
  def find
    @users = User.select([:id, :first_name, :last_name, :email]).where(
    'first_name like :name or last_name like :name', {:name => "%#{params[:name]}%"}).where('type = ?', "PatientUser").limit(200)

    respond_to do |f|
      f.html { render :layout => false }
      f.json { render :json => @users }
    end
  end

end
