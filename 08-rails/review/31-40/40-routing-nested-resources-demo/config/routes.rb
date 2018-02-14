Rails.application.routes.draw do

  resources :authors, only: [:show]

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'

	# requires the appropriate actions
	get 'authors/:id/posts', to: 'authors#posts_index'
	get 'authors/:id/posts/:post_id', to: 'authors#post'
end
