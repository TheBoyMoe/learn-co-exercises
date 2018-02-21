Rails.application.routes.draw do

  resources :artists do
    resources :songs, only: [:index, :show]
  end
  resources :songs


  # scope '/admin', module: 'admin' do
  #   resources :preferences, only: [:index]
  # end

  # route
  #  preferences GET  /admin/preferences(.:format) admin/preferences#index


  # replaces above scope - notice the helper method is prefixed with 'admin_'
  namespace :admin do
    resources :preferences, only: [:index, :update]
  end

  # route
  # admin_preferences GET  /admin/preferences(.:format) admin/preferences#index
end
