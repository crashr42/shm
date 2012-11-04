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
    @users = User.searh_doctors_by_email params[:name]
    respond_to do |f|
      f.html { render :layout => false }
      f.json { render :json => @users }
    end
  end
end
