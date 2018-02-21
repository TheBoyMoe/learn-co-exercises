class UsersController < ApplicationController
  before_action :require_login, only: [:show]

  def new
    @user = User.new
  end

  # signup - create user account
  def create
    @user = User.new(set_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_url(@user)
    else
      flash[:notice] = "Error creating account"
      redirect_to signup_url
    end
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  private
    def set_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
