class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  # 1st step request Github Identity - application_controller#authenticate_user
  # 2nd step request the access token
  # POST https://github.com/login/oauth/access_token
  
  def create
    resp = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_CLIENT_SECRET']
      req.params['redirect_uri'] = 'http://localhost:3000/auth'
      req.params['code'] = params[:code]
      # default reply is a string, set return to json string
      req.headers = {'Accept': 'application/json'}
    end
    session[:token] = JSON.parse(resp.body)['access_token']
    
    # use the access token to retrieve user info
    user_data = Faraday.get('https://api.github.com/user') do |req|
      req.params['access_token'] = session[:token]
      req.headers = {'Accept': 'application/json'}
    end
    session[:username] = JSON.parse(user_data.body)['login']

    redirect_to root_path
  end
end
