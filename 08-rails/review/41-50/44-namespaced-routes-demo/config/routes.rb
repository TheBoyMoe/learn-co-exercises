Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'

	# replace =>
	# get '/stats', to: 'stats#index'

	# 1st iteration - create a 'scope'
	# scope '/admin' do
	# 	resources :stats, only: [:index, :show, :new, :edit]
	# end

	# stats 			GET   /admin/stats(.:format)                       stats#index
	# new_stat 		GET   /admin/stats/new(.:format)                   stats#new
	# edit_stat 	GET   /admin/stats/:id/edit(.:format)              stats#edit
	# stat 				GET   /admin/stats/:id(.:format)                   stats#show



	# 2nd iteration - create a 'module'
	# scope '/admin', module: 'admin' do
	# 	resources :stats, only: [:index, :show, :new, :edit]
	# end

	# the routes will be handled by the stats controller in the Admin module
	# stats       GET   /admin/stats(.:format)                       admin/stats#index
	# new_stat    GET   /admin/stats/new(.:format)                   admin/stats#new
	# edit_stat   GET   /admin/stats/:id/edit(.:format)              admin/stats#edit
	# stat        GET   /admin/stats/:id(.:format)                   admin/stats#show



	# 3rd iteration - create a 'namespace'
	# create a namespace when you want to route with a module and use it's name as the url prefix
	# use a namespace when the path prefix and module names match
	namespace :admin do
		resources :stats, only: [:index, :show, :new, :edit]
	end

	# admin_stats 			GET   /admin/stats(.:format)                       admin/stats#index
	# new_admin_stat	 	GET   /admin/stats/new(.:format)                   admin/stats#new
	# edit_admin_stat 	GET   /admin/stats/:id/edit(.:format)              admin/stats#edit
	# admin_stat 				GET   /admin/stats/:id(.:format)                   admin/stats#show

end
