class Cabinet::ManagerController < ApplicationController

  layout 'cabinet/manager/layout'

  before_filter :_authorize

  private
  def _authorize
    authorize! :access, :manager_cabinet
  end

end
