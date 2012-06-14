Shm::Application.routes.draw do

  root :to => 'index#index'

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :users

  match '/error/500', :to => 'error#render_error'
  match '/error/404', :to => 'error#render_not_found'
  match '/error/403', :to => 'error#render_access_denied'

  match ':controller(/:action(/:id))(.:format)'

  if ::Rails.application.config.handle_errors
    match '*path', :to => redirect {|params, request| "/error/404?from=#{request.url}"}
  end

end
