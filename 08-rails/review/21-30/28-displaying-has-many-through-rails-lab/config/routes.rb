Rails.application.routes.draw do

  resources :doctors, only: [:show, :index]
  resources :patients, only: [:show, :index]
  resources :appointments, only: [:show]
  root to: 'doctors#index'
end
