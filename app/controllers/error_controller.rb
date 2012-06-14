class ErrorController < ApplicationController
  def render_error
    render :template => "/error/render_error", :status => 500
  end

  def render_not_found
    @path = params[:from]
    render :template => "/error/render_not_found", :status => 404
  end
end
