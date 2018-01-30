Rails.application.routes.draw do
	resources :posts, only:[:show, :index, :new, :create, :edit, :update]

	root to:'posts#index'
end
