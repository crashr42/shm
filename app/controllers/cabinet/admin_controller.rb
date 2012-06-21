class Cabinet::AdminController < ApplicationController

  layout 'cabinet/admin/layout'

  before_filter :_authorize

  private
  def _authorize
    authorize! :access, :admin_cabinet
  end

end
