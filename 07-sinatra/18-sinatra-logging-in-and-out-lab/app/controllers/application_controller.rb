require_relative '../../config/environment'
class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  # render the login page
  get '/' do
    erb :index
  end

  # handle user logins
  post '/login' do
    user = User.find_by(username: params[:username], password: params[:password])
    # if valid user
    if user
      # set session id
      session[:user_id] = user.id
      # redirect to home page - display username and balance
      redirect :'/account'
    else
      # render the error page
      erb :error
    end
  end

  get '/account' do
    if session[:user_id]
      # use Helper methods in view
      # this logic has been moved ot the Helpers.current_user method
      # @user = User.find(session[:user_id])

      # user logged in, render account page
      erb :account
    else
      # otherwise render the error page
      erb :error
    end
  end

  get '/logout' do
    session.clear

    redirect '/'
  end


end
