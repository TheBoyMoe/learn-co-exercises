class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    # app/views/home.erb
    erb :home
  end

  # render the signup page
  get '/registrations/signup' do
    erb :'/registrations/signup'
  end

  # handle the user data submitted by the signup form
  post '/registrations' do
    user = User.create(name: params[:name], email: params[:email], password: params[:password])

    # sign the user in
    session[:id] = user.id

    redirect '/users/home'
  end

  # render the login page
  get '/sessions/login' do
    erb :'sessions/login'
  end

  # handle login information submitted by the login page
  post '/sessions' do
    user = User.find_by(email: params[:email], password: params[:password])

    # log the user in
    session[:id] = user.id

    redirect '/users/home'
  end

  get '/sessions/logout' do
    # clear the session hash, logging out the user
    session.clear

    redirect '/'
  end

  get '/users/home' do
    # retrieve the logged in user using their session id
    @user = User.find(session[:id])

    erb :'/users/home'
  end

end
