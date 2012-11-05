class Cabinet::PatientController < ApplicationController

  layout 'cabinet/patient/layout'

  before_filter :_authorize, :_check_doctor_exists

  private
  def _authorize
    authorize! :access, :patient_cabinet
  end

  def _check_doctor_exists
    unless current_user.doctor_user.present?
      redirect_to :controller => :'cabinet/patient/doctor', :action => :new
    end
  end
end
