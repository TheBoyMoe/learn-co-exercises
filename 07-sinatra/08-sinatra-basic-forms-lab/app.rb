require_relative 'config/environment'

class App < Sinatra::Base

  get '/' do
    erb :index
  end

  post '/' do
    # instantiate the Puppy
    @puppy = Puppy.new( params[:name], params[:breed], params[:age])
    # @puppy = Puppy.new(params)

    erb :display_puppy
  end

  get '/new' do
    erb :create_puppy
  end
end
