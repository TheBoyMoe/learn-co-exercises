Rails.application.routes.draw do
  get 'posts/index'

  get 'posts/new'

  get 'posts/create'

  get 'posts/edit'

  get 'posts/update'

	resources :posts, only: [:index, :show, :new, :create, :edit]

	root to: 'posts#index'
end
