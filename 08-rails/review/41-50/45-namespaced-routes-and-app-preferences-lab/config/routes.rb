Rails.application.routes.draw do

  resources :artists do
    resources :songs, only: [:index, :show]
	end

  resources :songs

	namespace :admin do
		resources :preferences, only: [:index, :update]
	end

	# admin_preferences 	GET    /admin/preferences(.:format)        admin/preferences#index
	# admin_preference 		PATCH  /admin/preferences/:id(.:format)    admin/preferences#update
	# 										PUT    /admin/preferences/:id(.:format)    admin/preferences#update

end
