class Cabinet::Doctor::UserController < ApplicationController
  
  #find user by name
  def find
    @users = User.searh_patients_by_email params[:name]
    respond_to do |f|
      f.html { render :layout => false }
      f.json { render :json => @users }
    end
  end
  
  #find doctor
  def find_doctor
    @users = User.select([:id, :first_name, :last_name, :email]).where(
    'first_name ILIKE :name or last_name ILIKE :name', {:name => "%#{params[:name]}%"}).where('type = ?', "PatientUser").limit(200)

    respond_to do |f|
      f.html { render :layout => false }
      f.json { render :json => @users }
    end
  end
end
