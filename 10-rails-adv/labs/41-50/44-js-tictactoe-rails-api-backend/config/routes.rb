Rails.application.routes.draw do
  resources :games, only: [:create, :show, :update, :index]
  root 'home#index'
end
