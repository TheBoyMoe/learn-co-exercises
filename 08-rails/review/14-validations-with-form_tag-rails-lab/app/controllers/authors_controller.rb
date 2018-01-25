class AuthorsController < ApplicationController
  before_action :set_author, only: [:show, :edit, :update]

  def show
  end

  def new
    @author = Author.new
  end

  def create
    @author = Author.create(author_params)

    redirect_to author_path(@author)
  end

  def edit
  end

  def update

  end

  private
    def author_params
      params.permit(:name, :email, :phone_number)
    end

    def set_author
      @author = Author.find(params[:id])
    end
end
