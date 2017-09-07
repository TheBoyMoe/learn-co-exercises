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
      binding.pry
      @pirate = Pirate.create(name: params[:pirate][:name], weight: params[:pirate][:weight], height: params[:pirate][:height])

      params[:pirate][:ships].each do |ship_hash|
        ship = Ship.create(name: ship_hash[:name], category: ship_hash[:category], booty: ship_hash[:booty])
        ship.pirate = @pirate
        ship.save
      end

      redirect :"/pirates/#{@pirate.id}"
    end

  end
end
