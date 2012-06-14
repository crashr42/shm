Shm::Application.routes.draw do

  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  root :to => 'index#index'

  devise_for :users

  match '/error/500', :to => 'error#render_error'
  match '/error/404', :to => 'error#render_not_found'

  match ':controller(/:action(/:id))(.:format)'

  if ::Rails.application.config.handle_errors
    match '*path', :to => redirect {|params, request| "/error/404?from=#{request.url}"}
  end

end
