Rails.application.routes.draw do
	resources :artists, only: [:new, :create, :edit, :update, :show]
	resources :genres, only: [:new, :create, :edit, :update, :show]
	resources :songs, only: [:new, :create, :edit, :update, :show, :index]

	root to: 'songs#index'
end
