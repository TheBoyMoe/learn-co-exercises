Rails.application.routes.draw do
  devise_for :users

  root to: 'visitors#index'

  resources :users
	resources :posts
end
