Rails.application.routes.draw do
  devise_for :users
  get 'welcome/home'

  root to: 'welcome#home'
end
