class RepositoriesController < ApplicationController
  def index
    resp = Faraday.get("https://api.github.com/users/#{session[:username]}/repos") do |req|
      req.headers = {'Application': 'application/json'}
      req.params['sort'] = 'updated'
    end
    @repos = JSON.parse(resp.body)
    @repos = @repos.take(20)
  end

  def create
    resp = Faraday.post("https://api.github.com/user/repos") do |req|
      req.headers = {'Accept': 'application/json'}
      req.params['access_token'] = session[:token]
      req.body = {name: params[:name]}.to_json
    end
    redirect_to root_path
  end
end
