class SecretsController < ApplicationController
  before_action :require_login

  def show
    # redirect_to 'sessions#new' if not logged in
    # otherwise render page showing user name

    # if !current_user
      # redirect_to login_url

      # alternate
      # redirect_to controller: 'sessions', action: 'new'
    # end

  end

  private
    # could be moved to application_controller
    def require_login
      # redirect to login unless logged in
      redirect_to controller: 'sessions', action: 'new' unless current_user
    end

end
