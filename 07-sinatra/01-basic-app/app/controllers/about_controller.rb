class AboutController < ApplicationController

  get '/about' do
    erb :about
  end
end
