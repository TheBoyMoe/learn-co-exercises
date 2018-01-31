RailsBlog::Application.routes.draw do

  resources :users, only: [:index, :show, :new, :create]
  resources :tags, only: [:index, :show, :new, :create]
  resources :posts

	root to: 'posts#index'
end
