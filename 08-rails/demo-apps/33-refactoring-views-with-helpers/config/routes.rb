Rails.application.routes.draw do
  resources :authors, only: [:show, :index]
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]
end
