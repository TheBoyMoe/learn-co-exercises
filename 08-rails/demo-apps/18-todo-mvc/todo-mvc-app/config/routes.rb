Rails.application.routes.draw do

  # items are always created in the context of a list, so create them as a nested resource
  resources :lists do
    resources :items, only: [:create]
  end

  
  # list_items  POST   /lists/:list_id/items(.:format) items#create


  # lists       GET    /lists(.:format)                lists#index
  #             POST   /lists(.:format)                lists#create
  # new_list    GET    /lists/new(.:format)            lists#new
  # edit_list   GET    /lists/:id/edit(.:format)       lists#edit
  # list        GET    /lists/:id(.:format)            lists#show
  #             PATCH  /lists/:id(.:format)            lists#update
  #             PUT    /lists/:id(.:format)            lists#update
  #             DELETE /lists/:id(.:format)            lists#destroy


  root 'lists#index'
end
