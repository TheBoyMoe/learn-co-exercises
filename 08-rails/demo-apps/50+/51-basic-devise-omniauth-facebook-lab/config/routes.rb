Rails.application.routes.draw do

  get 'welcome/home'
  get 'about', to: 'static#about'

  root to: 'welcome#home'

  # devise_for :users

	# devise/facebook routes
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
end
