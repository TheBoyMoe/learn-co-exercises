Rails.application.routes.draw do

  # handles posts#index -> all posts, posts#show -> single post actions
  resources :posts, only: [:index, :show]
end
