class AuthorsController < ApplicationController
  def show
    @author = Author.find(params[:id])
  end

  def new
    @author = Author.new
  end

  def create
    # DOES NOT work - even though specs pass
    # begin
    #   @author = Author.create!(author_params)
    #   redirect_to author_path(@author)
    # rescue
    #   render :new
    # end

    @author = Author.new(author_params)
    if @author.valid?
      @author.save
      redirect_to author_path(@author)
    else
      render :new
    end
  end

  private

  def author_params
    params.permit(:email, :name)
  end
end
