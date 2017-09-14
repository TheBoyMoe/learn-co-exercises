class UsersController < ApplicationController

  # render the signup page
  get '/signup' do
    erb :'users/new'
  end

  # process user registration
  post '/users' do
    user = User.new(email: params[:email], password: params[:password])
    if user.save
      redirect :'/login'
    else
      erb :'users/new'
    end
  end

end
