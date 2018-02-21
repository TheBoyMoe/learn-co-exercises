Rails.application.routes.draw do

  resources :authors, only: [:show] do
    # nested reource for posts within the context of the author - possible since posts belong to author
    resources :posts, only: [:show, :index]
  end

  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'

  # filtering - replace the two routes with nested resources
  # get 'authors/:id/posts', to: 'authors#posts_index'
  # get 'authors/:id/posts/:post_id', to: 'authors#post'


  # nesting posts #show and #index adds the following two routes
  # author_posts GET  /authors/:author_id/posts(.:format)  posts#index
  # author_post GET  /authors/:author_id/posts/:id(.:format)  posts#show

end
