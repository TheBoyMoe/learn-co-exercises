=begin
  {
    "utf8"=>"✓", "authenticity_token"=>"D46BfUo7TVdp5yTTj6YtPjufRNT5g2X2nTbIhvIGoE69bBTInVm5NWH/CpQM4nypXTqh2OEtSY7tU4jhxbXT9Q==",
    "session"=>{
      "username"=>"tomjones"
    },
    "commit"=>"Log in",
    "controller"=>"sessions",
    "action"=>"create"
  }

=end

class SessionsController < ApplicationController

  def new
    # render login form, uses the sessions object
  end

  def create
    if !params[:name] || params[:name].empty?
      # redirect_to controller: 'sessions', action: 'new' # alternative
      redirect_to login_url
    else
      session[:name] = params[:name]
      redirect_to controller: 'sessions', action: 'show'
    end
  end

  def show
  end

  def destroy
    session[:name] = nil
    redirect_to login_url
  end

  # alternate
  # def create
  #   return redirect_to(controller: 'sessions',
  #                      action: 'new') if !params[:name] || params[:name].empty?
  #   session[:name] = params[:name]
  #   redirect_to controller: 'application', action: 'hello'
  # end

  # def destroy
  #   session.delete :name
  #   redirect_to controller: 'application', action: 'hello'
  # end
end
