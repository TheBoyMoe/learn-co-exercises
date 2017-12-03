class ListsController < ApplicationController
  before_action :set_list, only: [:show, :edit, :update]

  def index
    @list = List.new
    @lists = List.all
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    # raise params.inspect # DEBUG
    @list = List.new(list_params)
    if @list.valid?
      @list.save
      redirect_to lists_url # use full url for redirects
    else
      render :index
    end
  end

  private
    def set_list
      @list = List.find_by(id: params[:id])
    end

    def list_params
      params.require(:list).permit(:name)
    end
end
