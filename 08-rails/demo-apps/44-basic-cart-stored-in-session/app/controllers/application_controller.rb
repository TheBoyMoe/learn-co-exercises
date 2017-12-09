class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # declare helper methods making them available in the view
  # https://apidock.com/rails/ActionController/Helpers/ClassMethods/helper_method
  helper_method :cart

  def cart
    session[:cart] ||= []
  end
end
