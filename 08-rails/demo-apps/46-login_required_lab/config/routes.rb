Rails.application.routes.draw do

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
  
  get 'show' => 'sessions#show'
  get 'secret', to: 'secrets#show'

  resources :users, only: [:show]

  root 'sessions#new'
end
