class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  # login
  def create
    @user = User.find_by(name: params[:user][:name])
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to user_url(@user)
    else
      flash[:notice] = "Error logging in, account details not recognised"
      redirect_to login_url
    end
  end

  # logout
  def destroy
    session[:user_id] = nil
    redirect_to login_url
  end
end
