Rails.application.routes.draw do

	root to: 'static#home'
	resources :attractions

	# routes for sign/up/out
	get 'users/new', to: 'users#new'
	post 'users/new', to: 'users#create'
	get 'signin', to: 'sessions#new'
	post 'signin', to: 'sessions#create'
	delete 'signout', to: 'sessions#destroy'
	get 'users/:id', to: 'users#show', as: 'user'

	post 'rides/new', to: 'rides#new'
end