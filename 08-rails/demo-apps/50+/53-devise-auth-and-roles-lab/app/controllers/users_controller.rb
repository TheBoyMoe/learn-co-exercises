class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
	before_action :authenticate_user!, except: [:new, :create]
	before_action :admin_only, only: [:update, :destroy]

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.find_or_initialize_by(email: params[:email])
		@user.update(password: params[:password])

		redirect_to user_path(id: @user.id)
	end

	def show
		unless current_user.admin?
			unless @user == current_user
				redirect_to :back, :alert => "Access denied."
			end
		end
	end

	def edit
	end

	def update
		@user.update(user_params)
		flash[:notice] = "User account successfully updated"
		redirect_to users_url
	end

	def destroy
		@user.destroy
		flash[:notice] = "User account successfully deleted"
		redirect_to users_url
	end

	private
		def set_user
			@user = User.find_by(id: params[:id])
		end

		def user_params
			params.require(:user).permit(:email, :password, :role)
		end

		def admin_only
			unless current_user.admin?
				flash[:alert] = "Access denied"
				redirect_to users_url
			end
		end

end