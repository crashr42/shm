class ErrorController < ApplicationController
  def render_error
    render :template => "/error/render_error", :status => 500
  end

  def render_not_found
    @path = params[:from]
    render :template => "/error/render_not_found", :status => 404
  end

  def render_access_denied
    render :template => "/error/render_access_denied", :status => 403
  end
end
