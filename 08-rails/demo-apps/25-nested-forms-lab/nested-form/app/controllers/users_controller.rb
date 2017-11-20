class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
    # for each address object, you get an address hash/form fields
    @user.addresses.build(address_type: 'Home')
    @user.addresses.build(address_type: 'Business')
  end

  def create
    @user = User.new(user_params)
    @user.team = Team.find_or_create_by(name: 'The Avengers')
    # binding.pry
    if @user.save
      redirect_to user_path(@user) # => /users/:id
    else
      render :new
    end
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :addresses_attributes => [
          :street_1, :street_2, :address_type
        ])
    end
end
