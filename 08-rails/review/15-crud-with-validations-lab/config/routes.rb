Rails.application.routes.draw do
	resources :songs

	root to: 'songs#index'
end
