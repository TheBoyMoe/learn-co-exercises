Rails.application.routes.draw do
  resources :posts, only: [:show, :index, :new, :create]
  resources :comments
  resources :users, only: [:show]
  resources :categories, only: [:show]

	root to: 'posts#index'
end
