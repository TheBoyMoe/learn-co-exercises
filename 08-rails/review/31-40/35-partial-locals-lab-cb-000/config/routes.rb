Rails.application.routes.draw do
  resources :classrooms
  resources :students

	root 'classrooms#index'
end
