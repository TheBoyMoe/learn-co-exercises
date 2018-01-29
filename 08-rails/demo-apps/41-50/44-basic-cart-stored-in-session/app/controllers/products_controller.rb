class ProductsController < ApplicationController
  def index
  end

  def add
    if params[:product] && !params[:product].empty?
      cart << params[:product]
    end
    # redirect_to root_path # 302 status code
    render :index # 200 status code
  end


end
