Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # map any requests to the 'static#about' action -> in StaticController will be #about method
  get 'about', to: 'static#about'
  get 'contact', to: 'static#contact'
end
