Rails.application.routes.draw do
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

  get '/posts/:id/body', to: 'posts#body'
  root to: 'posts#index'
end
