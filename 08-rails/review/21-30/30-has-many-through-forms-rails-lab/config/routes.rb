Rails.application.routes.draw do
  resources :posts, only: [:show, :index, :new, :create]
  resources :comments, only: [:create]
  resources :users, only: [:show]
  resources :categories, only: [:show]

	root to: 'posts#index'
end
