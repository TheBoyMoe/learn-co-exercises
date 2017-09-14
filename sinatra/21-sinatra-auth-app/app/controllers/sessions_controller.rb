class SessionsController < ApplicationController

  # render the login page
  get '/login' do
    erb :'sessions/login'
  end

  # process the login
  post '/sessions' do
    # raise params.inspect # DEBUG
    # session[:email] = params[:email]
    login(params[:email], params[:password])

    redirect :'/posts'
  end

  get '/logout' do
    logout

    # redirect :'/login'
    redirect :'/'
  end
end
