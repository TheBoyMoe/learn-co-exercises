class OwnersController < ApplicationController

  # owners#index action
  get '/owners' do
    @owners = Owner.all
    erb :'/owners/index'
  end

  # owners#new action
  get '/owners/new' do
    @pets = Pet.all
    erb :'/owners/new'
  end

  # owners#create action
  post '/owners' do
    # {
    #   "owner"=> {
    #     "name"=>"Adele",
    #     "pet_ids"=> ["1", "2"]
    #   },
    #    "pet" => {
    #      "name" => 'Max'
    #   }
    # }
    # binding.pry # DEBUG

    # create a new owner and associate with existing pets
    # owner = Owner.new(name: params[:owner][:name])
    # pets = params[:owner][:pet_ids].collect do |pet_id|
    #   Pet.find(pet_id)
    # end
    # owner.pets = pets
    # owner.save

    # create a new owner and associate with existing pets using mass assignment
    # if none of the existing pets are selected, "owner" hash will only contain a "name" attribute
    owner = Owner.create(params[:owner])

    # create a new pet and associate with new owner
    if !params[:pet][:name].empty?
      pet = Pet.create(name: params[:pet][:name])
      owner.pets << pet
      owner.save
    end

    redirect :"/owners/#{owner.id}" # show action
  end

  # owners#show action
  get '/owners/:id' do
    @owner = Owner.find(params[:id])
    erb :'/owners/show'
  end

  # owners#edit action
  get '/owners/:id/edit' do
    @owner = Owner.find(params[:id])
    erb :'/owners/edit'
  end

  # owners#update
  patch '/owners/:id' do
    # {
    #    "owner"=> {
    #      "name"=>"Max Paine",
    #      "pet_ids"=>["1", "4", "6"]
    #    },
    #    "pet"=> {
    #      "name"=>"Octogon"
    #    },
    #    "captures"=>[],
    #    "id"=>"10"
    #  }
    owner = Owner.find(params[:id])
    # owner.name = params[:owner][:name]
    # owner.pets = params[:owner][:pet_ids].collect {|pet_id| Pet.find(pet_id)}

    # we can use ActiveRecord #update method and mass assignment to update 'owner'
    owner.update(params[:owner])

    if !params[:pet][:name].empty?
      owner.pets << Pet.create(name: params[:pet][:name])
    end
    owner.save

    redirect :"/owners/#{owner.id}"
  end
end
