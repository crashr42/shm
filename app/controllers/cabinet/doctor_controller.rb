class Cabinet::DoctorController < ApplicationController
  layout 'cabinet/doctor/layout'

  before_filter :_authorize

  private
  def _authorize
    authorize! :access, :doctor_cabinet
  end
end
