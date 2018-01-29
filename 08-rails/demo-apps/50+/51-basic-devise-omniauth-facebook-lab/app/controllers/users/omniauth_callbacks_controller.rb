class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

	# handle the omniauth callback
	def facebook
		@user = User.from_omniauth(request.env["omniauth.auth"])
		sign_in_and_redirect @user
	end
end