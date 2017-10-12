class PetsController < ApplicationController

  # pets#index action
  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  # pets#new action
  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  # pets#create action
  post '/pets' do
    # {
    #   "pet"=> {
    #     "name"=>"Oliver",
    #     "owner_id"=>"2"
    #   },
    #   "owner"=> {
    #     "name"=>"Bill"
    #   },
    #   "create_pet"=>"Create Pet",
    #   "captures"=>[]
    # }
    pet = Pet.create(params[:pet])
    new_owner = params[:owner][:name]
    if !new_owner.empty?
      # if a new owner is defined, update the owner
      pet.owner = Owner.new(name: new_owner)
      pet.save
    end
    redirect :"/pets/#{pet.id}"
  end

  # pets#show action
  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  # pets#edit action
  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'/pets/edit'
  end

  # pets#update action
  patch '/pets/:id' do
    # {
    #   "pet"=> {
    #     "name"=>"Fido",
    #     "owner_id"=>"2"
    #   },
    #   "owner"=> {
    #     "name"=>"John" # new owner
    #   },
    #   "create_pet"=>"Update Pet", # submit button
    #   "captures"=>[],
    #   "id"=>"4" # pet.id
    # }

    # update pet attr values
    pet = Pet.find(params[:id])
    pet.name = params[:pet][:name]
    pet.owner = Owner.find(params[:pet][:owner_id])

    # if a new owner has been specified
    new_owner_name = params[:owner][:name]
    if !new_owner_name.empty?
      pet.owner = Owner.new(name: new_owner_name)
    end
    pet.save

    redirect :"/pets/#{pet.id}" # show action
  end
end
