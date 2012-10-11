class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  before_filter :manage_user

  private
  def manage_user
    User.current = current_user
  end

  if ::Rails.application.config.handle_errors
    rescue_from Exception do |exception|
      redirect_to "/error/500"
    end

    rescue_from ActiveRecord::RecordNotFound do |exception|
      redirect_to "/error/404?from#{request.url}"
    end

    rescue_from CanCan::AccessDenied do |exception|
      redirect_to "/error/403"
    end
  end

end
