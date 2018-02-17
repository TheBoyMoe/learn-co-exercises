Rails.application.routes.draw do
	get 'cart', to: 'products#index'
	post 'add', to: 'products#add'
	root to: 'products#index'
end
