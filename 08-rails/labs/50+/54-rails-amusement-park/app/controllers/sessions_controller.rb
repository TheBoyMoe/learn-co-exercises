class SessionsController < ApplicationController

	def new
		@user = User.new
	end

	# user login
	def create
		@user = User.find_by(name: params[:user][:name])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: 'You successfully logged in'
		else
			redirect_to signin_path, alert: "Login failed"
		end
	end

	# user logout
	def destroy
		session[:user_id] = nil
		redirect_to root_path, notice: "You've been successfully logged out"
	end

	private
		def user_params
			params.require(:user).permit(:name, :password)
		end
end