# noinspection RubyInterpreter
Rails.application.routes.draw do


	get 'pages/home'
	root to: 'pages#home'

	# devise_for :users

	# replaces above line - allows the app to receive the callback from facebook
	devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

end
