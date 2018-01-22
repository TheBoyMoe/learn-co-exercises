Rails.application.routes.draw do
  resources :students, only: [:index, :show, :new]
end
