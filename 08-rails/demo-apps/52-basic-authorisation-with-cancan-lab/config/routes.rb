Rails.application.routes.draw do

	resources :notes

	get 'login', to: 'sessions#new'
	post 'login', to: 'sessions#create'
	delete 'logout', to: 'sessions#destroy'

	get 'signup', to: 'users#new'
	post 'signup', to: 'users#create'

	get 'users/:id', to: 'users#show', as: 'user'

  root 'sessions#new'
end
