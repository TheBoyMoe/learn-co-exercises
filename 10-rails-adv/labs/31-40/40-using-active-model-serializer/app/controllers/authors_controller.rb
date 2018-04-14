class AuthorsController < ApplicationController

  def index
    @authors = Author.all
    render json: @authors, status: 200
  end

  def show
    @author = Author.find(params[:id])
    render json: @author, status: 200
  end
end
