class Application < Sinatra::Base
  # Write your code here!

  get '/' do
    erb :index
  end

  post '/' do
    @name = params[:user_name]

    erb :greet
  end
end
