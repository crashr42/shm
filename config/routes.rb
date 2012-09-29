Shm::Application.routes.draw do

  root :to => 'index#index'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  match '/error/500', :to => 'error#render_error'
  match '/error/404', :to => 'error#render_not_found'
  match '/error/403', :to => 'error#render_access_denied'

  match '/doctor(/:path)', :to => redirect {|params, request| "/cabinet/doctor/#{params[:path]}"}
  match '/patient(/:path)', :to => redirect {|params, request| "/cabinet/patient/#{params[:path]}"}
  match '/admin(/:path)', :to => redirect {|params, request| "/cabinet/admin/#{params[:path]}"}
  match '/manager(/:path)', :to => redirect {|params, request| "/cabinet/manager/#{params[:path]}"}

  namespace :cabinet do
    namespace :doctor do
      root :to => 'index#index'
      match '/' => 'index#index'
    end
    namespace :patient do
      root :to => 'index#index'
      match '/' => 'index#index'
    end
    namespace :admin do
      root :to => 'index#index'
      match '/' => 'index#index'
    end
    namespace :manager do
      root :to => 'index#index'
      match '/' => 'index#index'
      match '/event' => 'event#index'
      match '/event/new' => 'event#new'
      match '/event/find' => 'event#find'
    end
  end

  match ':controller(/:action(/:id))(.:format)'

  if ::Rails.application.config.handle_errors
    match '*path', :to => redirect {|params, request| "/error/404?from=#{request.url}"}
  end

end
