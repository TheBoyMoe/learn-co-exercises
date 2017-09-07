require './config/environment'

module FormsLab
  class App < Sinatra::Base

    get '/' do
      erb :root
    end

    # /pirates#index action
    get '/pirates' do
      @pirates = Pirate.all

      erb :'pirates/index'
    end

    # /pirates#new action - returns a form that allows user to add a pirate
    get '/pirates/new' do
      erb :'pirates/new'
    end

    # /pirates#show action
    get '/pirates/:id' do
      @pirate = Pirate.find(params[:id])

      erb :'pirates/show'
    end


    # /pirates#create action - save the new pirate(and ships) to the database
    post '/pirates' do
      # binding.pry # DEBUG

      # simply passing in the params hash will not work since the 'ships' array is of hashes,
      # Active Record is expecting an array of ship instances
      @pirate = Pirate.create(name: params[:pirate][:name], weight: params[:pirate][:weight], height: params[:pirate][:height])

      params[:pirate][:ships].each do |ship_hash|
        # ship = Ship.create(name: ship_hash[:name], category: ship_hash[:category], booty: ship_hash[:booty])

        # you can't pass in a hash containing attributes not defined in the model's class
        ship = Ship.new(ship_hash)
        ship.pirate = @pirate
        ship.save
      end

      redirect :"/pirates/#{@pirate.id}"
    end

  end
end
