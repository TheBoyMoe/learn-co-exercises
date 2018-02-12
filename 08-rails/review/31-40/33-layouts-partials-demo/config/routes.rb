Rails.application.routes.draw do
  root 'products#index'

	get 'about', to: 'products#about'

	get 'home', to: 'static#home'

	get 'admin', to: 'store_admin#home'

	get 'orders', to: 'store_admin#orders'

	get 'invoice', to: 'store_admin#invoice'
end
