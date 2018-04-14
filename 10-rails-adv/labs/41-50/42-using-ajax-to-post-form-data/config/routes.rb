Rails.application.routes.draw do
  resources :authors, only: [:show]
  resources :posts, except: [:delete]
  get 'posts/:id/post_data', to: 'posts#post_data'
  
  root to: 'posts#index'
end
