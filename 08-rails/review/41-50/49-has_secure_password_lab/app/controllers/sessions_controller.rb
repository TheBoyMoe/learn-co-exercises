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

	end

	# log the user out
	def destroy

	end
end