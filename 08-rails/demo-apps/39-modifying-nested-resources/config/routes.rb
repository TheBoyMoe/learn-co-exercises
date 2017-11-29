Rails.application.routes.draw do

  resources :authors, only: [:show, :index] do
    resources :posts, only: [:show, :index, :new, :edit]
  end

# generates the following authors routes
#    author_posts GET    /authors/:author_id/posts(.:format)       posts#index  => update controller action
#  new_author_post GET   /authors/:author_id/posts/new(.:format)   posts#new    => update controller action
#      author_post GET   /authors/:author_id/posts/:id(.:format)   posts#show   => update controller action
#          authors GET   /authors(.:format)                        authors#index
#           author GET   /authors/:id(.:format)                    authors#show


  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  root 'posts#index'
end
