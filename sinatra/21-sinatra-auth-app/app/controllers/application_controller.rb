class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'my_little_secret'
  end

  get '/' do
    erb :index
  end

  # helper methods available in all other controllers
  helpers do

    def logged_in?
      #determine whether the current user is logged in depending on whether or not session hash contains an email address
      # session[:email] && session[:email] != ''
      !!current_user
    end

    def login(email, password)
      # check that the user exists & that you can authenticate them
      user = User.find_by(email: email)
      if user && user.authenticate(password)
        session[:email] = email
      else
        # otherwise redirect
        redirect :'/login'
      end
    end

    def logout
      session.clear
    end

    def current_user
      # query the database returning the current user based on their email
      @current_user ||= User.find_by(email: session[:email]) if session[:email]  && session[:email] != ''
    end

  end


end
