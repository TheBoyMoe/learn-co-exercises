FlatironKitchen::Application.routes.draw do

  resources :ingredients, only: [:new, :show, :index, :edit, :create, :update]
  resources :recipes, only: [:new, :show, :index, :edit, :create, :update]

end
