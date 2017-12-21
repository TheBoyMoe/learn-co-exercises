class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You've been successfully logged in"
      redirect_to user_path @user
    else
      flash[:warning] = "Error creating account"
      redirect_to signup_url
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:name)
    end
end
