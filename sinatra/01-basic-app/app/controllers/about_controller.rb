class AboutController < Sinatra::Base

  get '/about' do
    "You've reached the about page"
  end
end
