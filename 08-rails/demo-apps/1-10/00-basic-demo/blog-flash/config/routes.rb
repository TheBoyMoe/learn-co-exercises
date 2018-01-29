Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # A rails route maps a URL to a Controller(Class) and Action(mehod)

  # map any requests to the 'static#about' action -> in StaticController will be #about method

  # => URL          controller#action (class#method) => app/views/[controller_name]/[action_name].html.erb
  get 'about', to: 'static#about'
  get 'contact', to: 'static#contact'
  get 'home', to: 'post#home'
  get 'posts', to: 'post#index'
  get 'posts/:id', to: 'post#show', as: 'post'

  root 'static#home'
end
