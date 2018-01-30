Rails.application.routes.draw do
	resources :posts, only: [:show, :create, :new, :index]
	resources :users, only: [:show, :create, :new, :index]
end
