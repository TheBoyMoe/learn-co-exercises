Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :artists, :songs, only: [:index, :show]

  # updated routes ??? are these right
  # get '/artists/new', to: 'artists#show', id: 'new'
  # get '/artists/edit', to: 'artists#show', id: 'edit'

  # get '/songs/new', to: 'songs#show', id: 'new'
  # get'/songs/edit', to: 'songs#show', id: 'edit'

  root to: 'artists#index'
end
