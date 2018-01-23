Rails.application.routes.draw do
  resources :accounts

  get 'admin/dashboard'

  get 'admin/stats'

  get 'admin/financials'

  get 'admin/settings'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
