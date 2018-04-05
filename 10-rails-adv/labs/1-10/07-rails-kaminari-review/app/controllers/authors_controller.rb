class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def index
    @authors = Author.all
  end

  def edit
    @author = Author.find(params[:id])
  end

  def update
    @author = Author.find(params[:id])
    @author.update(author_params)
    redirect_to author_path(@author)
  end

  def create
    @author = Author.create(author_params)
    redirect_to author_path(@author)
  end

  def new
    @author = Author.new
  end

  private

  def author_params
    params.require(:author).permit(:bio, :name)
  end
end
