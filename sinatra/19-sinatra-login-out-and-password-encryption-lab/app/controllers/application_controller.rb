require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

  # render signup page
	get "/signup" do
		erb :signup
	end

  # process user signup
	post "/signup" do
		# create a new user instance
    user = User.new(username: params[:username], password: params[:password])

    # if the user can be saved, redirect them to /login
    if user.save
      redirect :'/login'
    else
      redirect :'/failure'
    end
	end

  # render the login page
	get "/login" do
		erb :login
	end

  # process user login
	post "/login" do
		# check if the user is valid
    user = User.find_by(username: params[:username])

    # if they're vaild and authenticated, log them in
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect :'/success'
    else
      redirect :'/failure'
    end

	end

	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
