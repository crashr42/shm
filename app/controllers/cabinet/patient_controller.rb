class Cabinet::PatientController < ApplicationController

  layout 'cabinet/patient/layout'

  before_filter :_authorize

  private
  def _authorize
    authorize! :access, :patient_cabinet
  end

end
