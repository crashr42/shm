class ApplicationController < ActionController::Base
  protect_from_forgery

  if ::Rails.application.config.handle_errors
    rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from CanCan::AccessDenied, :with => :render_access_denied
  end

  private
  def render_error(exception)
    redirect_to "/error/500"
  end

  def render_not_found(exception)
    redirect_to "/error/404?from#{request.url}"
  end

  def render_access_denied
    redirect_to "/error/403"
  end
end
