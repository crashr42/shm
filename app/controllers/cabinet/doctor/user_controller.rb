class Cabinet::Doctor::UserController < ApplicationController
  
  layout 'cabinet/doctor/layout'
  
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

  def index
  
  end

  def get_doctors
    respond_to{|f|
      f.html { render :layout => false }
      f.json { render :json => DoctorUser.select("users.id, first_name, last_name").where("users.id <> ?", User.current.id).to_json }
    }
  end
end
