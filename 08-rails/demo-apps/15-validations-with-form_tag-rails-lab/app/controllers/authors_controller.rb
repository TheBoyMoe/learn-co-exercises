class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update]

  def index
    @authors = Author.all
  end

  def show
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new(author_params)
    if @author.valid?
      @author.save
      redirect_to author_path(@author)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @author.update(author_params)
    if @author.valid?
      redirect_to author_path(@author)
    else
      render :edit
    end
  end

  private

  def author_params
    params.permit(:name, :email, :phone_number)
  end

  def set_author
    @author = Author.find(params[:id])
  end
end
