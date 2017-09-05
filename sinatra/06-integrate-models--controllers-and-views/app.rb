require_relative 'config/environment'
require_relative 'models/text_analyzer' # access model class

class App < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/' do
    # instance variable is available from the erb template
    # we can call it, and it's methods from 'results.erb'

    # an instance of the model is created using text entered by the user, the instance is passed back to the view
    @analyzed_text = TextAnalyzer.new(params[:user_text])

    erb :results
  end
end
