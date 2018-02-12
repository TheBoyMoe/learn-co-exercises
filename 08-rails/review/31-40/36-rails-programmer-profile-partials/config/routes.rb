Rails.application.routes.draw do
  root 'programmers#index'
  resources :programmers
end
