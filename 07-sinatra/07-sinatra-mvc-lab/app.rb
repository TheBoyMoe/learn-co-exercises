require_relative 'config/environment'

class App < Sinatra::Base

  get '/' do
    erb :user_input
  end

  post '/piglatinize' do
    # instantiate the piglatinizer class using the users input text
    p = PigLatinizer.new
    phrase = params[:user_phrase]
    @latinized_text = p.to_pig_latin(phrase)

    erb :user_output
  end
end
