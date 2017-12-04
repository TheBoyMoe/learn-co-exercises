class ListsController < ApplicationController
  before_action :set_list, only: [:show]

  def index
    @list = List.new
    @lists = List.all
  end

  def show
    @item = @list.items.build
  end

  def new
    @list = List.new
  end

  def create
    # raise params.inspect # DEBUG
    @list = List.new(list_params)
    if @list.save
      redirect_to list_url(@list) # use full url for redirects
    else
      @lists = List.all
      # when you render you're not creating a new request
      # check the @list object for errors in the view
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
