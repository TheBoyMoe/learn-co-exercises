Rails.application.routes.draw do
  root 'welcome#home'

	# add http://localhost:3000/auth/facebook/callback to the 'Client OAuth Settings' on Facebook - and enable 'Client OAuth Login' and 'Web OAuth Login'
  get '/auth/facebook/callback', to: 'sessions#create'
end
