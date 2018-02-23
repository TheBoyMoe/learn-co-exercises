class UsersController < ApplicationController

	def new
		@user = User.new
	end

	# user registration/signup
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "You successfully registered"
		else
			redirect_to users_path, alert: "Registration failed"
		end
	end

	def show
		if session[:user_id]
			@user = User.find(params[:id])
		else
			redirect_to root_path, alert: "You need to be logged in to view the page"
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :password, :height, :nausea, :happiness, :tickets, :admin)
		end
end