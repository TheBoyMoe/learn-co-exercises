Rails.application.routes.draw do
  resources :posts, only: [:index, :show, :new, :create, :edit, :update]

	root to: "posts#index"
end