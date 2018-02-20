class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:create, :new]
	before_action :admin_only, only: [:destroy]

	def index
		@user = User.all
	end

	def show
		if !current_user.admin? || @user != current_user
			redirect_to :back, alert: 'Access denied.'
		end
	end

	def new
	end

	def create
		@user = User.find_or_initialize_by(email: params[:email])
		@user.update(password: params[:password])
		redirect_to user_path(id: @user.id)
	end

	def edit
	end

	def update
		if @user.update_attributes(secure_params)
			redirect_to users_path, notice: "User updated."
		else
			redirect_to users_path, alert: "Unable to update user."
		end
	end

	def destroy
		@user.destroy
		redirect_to users_path, notice: 'User deleted.'
	end


	private
		def set_user
			@user = User.find(params[:id])
		end

		def admin_only
			unless current_user.admin? || @user == current_user
				redirect_to users_path, alert: "Access denied."
			end
		end

		def secure_params
			params.require(:user).permit(:role)
		end

end