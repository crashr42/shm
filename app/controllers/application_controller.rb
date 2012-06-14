class ApplicationController < ActionController::Base
  protect_from_forgery

  if ::Rails.application.config.handle_errors
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  end

  private
  def render_error(exception)
    redirect_to :controller => "/error", :action => :render_error
  end

  def render_not_found(exception)
    redirect_to :controller => "/error", :action => :render_not_found, :from => request.url
  end
end
