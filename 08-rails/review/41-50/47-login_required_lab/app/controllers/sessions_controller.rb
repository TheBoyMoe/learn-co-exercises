class SessionsController < ApplicationController

	def new
	end

	def create
		# params hash
		# {
		# 	"utf8"=>"✓",
		#  	"authenticity_token"=>"..",
		# 	"name"=>"jon smyth",
		# 	"commit"=>"Login",
		# 	"controller"=>"sessions",
		# 	"action"=>"create"
		# }
		if params[:name].nil? || params[:name].empty?
			redirect_to new_session_path
		else
			session[:name] = params[:name]
			redirect_to homepage_path
		end

	end

	def destroy
		session[:name] = nil
		redirect_to new_session_path
	end
end