Rails.application.routes.draw do
  resources :students, only: [:index, :show, :new, :create]

	root to: 'students#index'
end
