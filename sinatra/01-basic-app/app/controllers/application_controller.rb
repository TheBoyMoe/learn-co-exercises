class ApplicationController < Sinatra::Base

  # generally you don't define routes in the application controller, define tham in other controllers.

  # define functionality in here that you want the other controllers to inherit

  # tell your controllers where to find your erb templates & you're public directory
  # by default sinatra will look in controller/views for erb templates
  configure do
  	set :views, "app/views"
  	set :public_dir, "public"
  end

  get '/' do
    erb :index
  end

end
