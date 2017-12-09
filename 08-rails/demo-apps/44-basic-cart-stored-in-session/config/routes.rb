Rails.application.routes.draw do

  # display the products
  root 'products#index'

  # add products tot he cart
  post '/', to: 'products#add'
end
