class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all

  before_filter :manage_user, :timeout_block, :current_url, :disable_cache_for_xhr

  private
  # Отключаем кэширование ajax запросов в браузере
  def disable_cache_for_xhr
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 01 Jan 1990 00:00:00 GMT'
  end

  def current_url
    cookies[:current_url] = request.url if request.get?
  end

  def manage_user
    User.current = current_user
  end

  # Перехват запросов от пользователей заблокированных по таймауту
  def timeout_block
    if current_user.present? && current_user.timeout_block
      redirect_to :controller => :'/block', :action => :new
    end
  end

  # Перехват ошибок
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

  # Hook: для ajax запрсов - view будет отдаваться без layout
  def render(options = nil, extra_options = {}, &block)
    if !options.nil? && options.is_a?(Hash)
      options = {:layout => !request.xhr?}.merge(options)
    else
      options = {:layout => !request.xhr?}
    end
    super(options, extra_options)
  end
end
