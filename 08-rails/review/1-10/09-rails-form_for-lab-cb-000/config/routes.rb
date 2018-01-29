Rails.application.routes.draw do
  resources :students, only: [:index, :show, :new, :create, :edit, :update]
	resources :school_classes, only: [:index, :show, :new, :create, :edit, :update]

	root to: 'students#index'
end
