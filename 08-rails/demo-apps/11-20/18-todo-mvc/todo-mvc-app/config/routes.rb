Rails.application.routes.draw do

  get 'items/create'

  # items are always created in the context of a list, so create them as a nested resource
  resources :lists do
    resources :items
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


  # items_create   GET    /items/create(.:format)                  items#create
  #   list_items   GET    /lists/:list_id/items(.:format)          items#index
  #                POST   /lists/:list_id/items(.:format)          items#create
  # new_list_item  GET    /lists/:list_id/items/new(.:format)      items#new
  # edit_list_item GET    /lists/:list_id/items/:id/edit(.:format) items#edit
  #      list_item GET    /lists/:list_id/items/:id(.:format)      items#show
  #                PATCH  /lists/:list_id/items/:id(.:format)      items#update
  #                PUT    /lists/:list_id/items/:id(.:format)      items#update
  #                DELETE /lists/:list_id/items/:id(.:format)      items#destroy


  root 'lists#index'
end
