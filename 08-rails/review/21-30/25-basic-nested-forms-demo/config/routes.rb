Rails.application.routes.draw do
  resources :people, only: [:index, :show, :new, :create]
  root to: 'people#index'
end
