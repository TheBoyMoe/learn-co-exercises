Rails.application.routes.draw do
  resources :accounts
  get 'categories/show'

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]
  resources :categories
end
