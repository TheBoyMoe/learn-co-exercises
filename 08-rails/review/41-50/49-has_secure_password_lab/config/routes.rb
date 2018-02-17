Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
	resources :sessions, only: [:new, :create, :destroy]

	root to: 'sessions#new'

	# users 				POST   /users(.:format)        users#create
	# new_user 			GET    /users/new(.:format)    users#new
	# user 					GET    /users/:id(.:format)    users#show
	# sessions 			POST   /sessions(.:format)     sessions#create
	# new_session 	GET    /sessions/new(.:format) sessions#new
	# session 			DELETE /sessions/:id(.:format) sessions#destroy
	# root GET    				 /                       session#new
end
