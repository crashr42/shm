Shm::Application.routes.draw do
  root :to => 'index#index'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  match '/error/500', :to => 'error#render_error'
  match '/error/404', :to => 'error#render_not_found'
  match '/error/403', :to => 'error#render_access_denied'

  resources :bid, :block
  resources :user, :path_names => {:show => :profile}

  match '/doctor(/:path)', :to => redirect { |params, request| "/cabinet/doctor/#{params[:path]}" }
  match '/patient(/:path)', :to => redirect { |params, request| "/cabinet/patient/#{params[:path]}" }
  match '/admin(/:path)', :to => redirect { |params, request| "/cabinet/admin/#{params[:path]}" }
  match '/manager(/:path)', :to => redirect { |params, request| "/cabinet/manager/#{params[:path]}" }

  namespace :cabinet do
    namespace :doctor do
      root :to => 'index#index'
      match '/' => 'index#index'

      resources :appointments, :controller => 'appointment'
      resources :documents, :controller => 'document'
      resources :patient, :parameter, :user

      match 'link/parameter/:parameter_id/to/:patient_id' => 'parameter#link', :via => :post
      match 'unlink/parameter/:parameter_id/from/:patient_id' => 'parameter#unlink', :via => :post
      
      match 'user/find' => 'user#find', :via => :post
      match 'user/find_doctor' => 'user#find_doctor', :via => :post
    end
    namespace :patient do
      root :to => 'index#index'
      match '/' => 'index#index'

      match '/doctor/find' => 'doctor#find'
      match '/appointment/find' => 'appointment#find'
      match '/event/unsubscribe/:id' => 'event#unsubscribe'

      resources :calendar, :event, :doctor, :appointment, :parameter
    end
    namespace :admin do
      root :to => 'index#index'
      match '/' => 'index#index'
    end
    namespace :manager do
      root :to => 'index#index'
      match '/' => 'index#index'

      resources :parameter, :bid, :event, :user, :rule_parameter_input

      match '/event/find' => 'event#find', :via => :post
      match '/event/find_attendee' => 'event#find_attendee', :via => :post
      match '/event/json' => 'event#json_format', :via => :post

      match '/rule/new' => 'recurrence#new', :via => :get
      match '/rule/find' => 'recurrence#find', :via => :post
      match '/rule/edit/:id' => 'recurrence#edit', :via => :get

      match '/user/find' => 'user#find', :via => :post
    end
  end

  match ':controller(/:action(/:id))(.:format)'

  if ::Rails.application.config.handle_errors
    match '*path', :to => redirect { |params, request| "/error/404?from=#{request.url}" }
  end
end
