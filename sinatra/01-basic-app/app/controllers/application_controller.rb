class ApplicationController < Sinatra::Base

  get '/' do
    'Hello from Sinatra'
  end

  get '/contact' do
    "Feel free to drop us a line!"
  end

  get '/support' do
    "You've reached the support page!"
  end
end
