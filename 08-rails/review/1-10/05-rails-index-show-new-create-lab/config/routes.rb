Rails.application.routes.draw do
	resources :coupons, only: [:new, :create, :show, :index]

	root to: 'coupons#index'
end
