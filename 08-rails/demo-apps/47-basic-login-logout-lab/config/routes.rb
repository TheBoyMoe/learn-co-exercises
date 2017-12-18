Rails.application.routes.draw do

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  post '/logout', to: 'sessions#destroy'

  get '/show/:id', to: 'users#show', as: :user

	root 'session#new'

  end
