# params hash
# {
# 		"utf8"=>"✓",
# 		"authenticity_token"=>"...",
# 		"user"=>{
# 				"name"=>"tom jones",
# 				"password"=>"12345678",
# 				"password_confirmation"=>"12345678" # signup form
# 		},
# 		"commit"=>"Login",
# 		"controller"=>"sessions",
# 		"action"=>"create"
# }

class SessionsController < ApplicationController

	# render login form
	def new
		@user = User.new
	end

	# log the user in
	def create
		@user = User.find_by(name: params[:user][:name])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			redirect_to user_path(@user), notice: "You've successfully logged in"
		else
			redirect_to new_session_path, alert: "You failed to login"
		end
	end

	# log the user out
	def destroy
		session[:user_id] = nil
		redirect_to new_session_path, notice: "You've successfully logged out"
	end
end