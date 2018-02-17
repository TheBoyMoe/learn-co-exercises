class UsersController < ApplicationController

	# render the signup form
	def new
		@user = User.new
	end

	# create the user & log them in
	def create

	end

	# render user page on login/signup
	def show

	end
end