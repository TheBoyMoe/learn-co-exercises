Rails.application.routes.draw do

	resources :posts, only: [:index, :show, :new, :create, :edit]
	resources :categories, only: [:index]

	root to: 'posts#index'
end
