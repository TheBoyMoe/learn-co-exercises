Rails.application.routes.draw do
  resources :authors, only: [:new, :create, :show, :edit, :update, :index]
  resources :posts, only: [:new, :create, :show, :edit, :update, :index]
end
