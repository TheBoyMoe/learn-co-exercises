Rails.application.routes.draw do
  resources :students, only: [:index, :new, :create, :show]
end
