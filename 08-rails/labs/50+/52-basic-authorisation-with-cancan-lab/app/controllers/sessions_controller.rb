class SessionsController < ApplicationController

  def create
    @user = User.find_by(name: params[:user][:name])
    if @user
      session[:user_id] = @user.id
      flash[:notice] = "You've been successfully logged in"
      redirect_to user_url @user
    else
      flash[:warning] = "You're account details could no be found"
      redirect_to login_url
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've been successfully logged out"
    redirect_to login_url
  end


end
