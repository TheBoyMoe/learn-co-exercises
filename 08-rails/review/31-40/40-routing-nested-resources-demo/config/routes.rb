Rails.application.routes.draw do

	root 'posts#index'

	# manually creating the routes
	# get 'authors/:id/posts', to: 'authors#posts_index'
	# get 'authors/:id/posts/:post_id', to: 'authors#post'

	# A post belongs_to :author(an author has_many :posts) a post can logically
	# be considered a child object to an author, it can also be considered a
	# nested resource of an author for routing purposes
	resources :authors, only: [:show] do
		# these actions will be routed to the posts controller, which will need to be updated
		resources :posts, only: [:show, :index]
	end

	# allow users to see all, create and edit posts
	resources :posts, only: [:index, :show, :new, :create, :edit, :update]


	# Prefix 				Verb  URI Pattern                             Controller#Action
	# root 					GET   /                                       posts#index
	# author_posts 	GET   /authors/:author_id/posts(.:format)     posts#index			#=> author_posts(author_id)
	# author_post 	GET   /authors/:author_id/posts/:id(.:format) posts#show			#=> author_post(author_id, post_id)
	# author 				GET   /authors/:id(.:format)                  authors#show
	# posts 				GET   /posts(.:format)                        posts#index
  #      					POST  /posts(.:format)                        posts#create
	# new_post 			GET   /posts/new(.:format)                    posts#new
	# edit_post 		GET   /posts/:id/edit(.:format)               posts#edit
	# post 					GET   /posts/:id(.:format)                    posts#show
	# 							PATCH /posts/:id(.:format)                    posts#update
	# 							PUT   /posts/:id(.:format)                    posts#update

end
