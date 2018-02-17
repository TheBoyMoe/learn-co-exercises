Rails.application.routes.draw do
	resources :sessions, only: [:new, :create]

	root to: 'sessions#new'

	post '/sessions', to: 'sessions#destroy'

	get '/homepage', to: 'secrets#show'
	get '/secretpage', to: 'secrets#secretpage'
end
