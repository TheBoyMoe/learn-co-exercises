class UsersController < ApplicationController

	# render the signup form
	def new
		@user = User.new
	end

	# create the user & log them in
	def create
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "You've successfully registered"
		else
			redirect_to new_user_path, alert: "You're attempt to register has failed"
		end
	end

	# render user page on login/signup
	def show
		if session[:user_id]
			@user = User.find(params[:id])
		else
			redirect_to new_session_path, alert: "You need to be logged in"
		end
	end

	private
		def user_params
			params.require(:user).permit(:name, :password, :password_confirmation)
		end
end