=begin
{
  "utf8"=>"✓",
  "item"=> {
    "description"=>"Cookies"
   },
   "commit"=>"Create Item",
   "controller"=>"items",
   "action"=>"create",
   "list_id"=>"7"
}
=end

class ItemsController < ApplicationController

  # POST '/lists/:list_id/item'
  def create
    # retireive the appropriate list, and associate the item with it's parent
    @list = List.find(params[:list_id])
    @item = @list.items.build(item_params)
    if @item.save
      redirect_to list_path(@list)
    else
      # 'lists/show' requires @list and @item - check for errors in view
      render 'lists/show'
    end
  end

  # PATCH '/lists/:list_id/item/:id'
  def update
    # logger.debug(params)
    @list = List.find_by(id: params[:list_id])
    @item = @list.items.find_by(id: params[:id])
    if @item
      # @item.status = params[:item][:status]
      # @item.save
      @item.update(item_params) # replaces above two lines
      redirect_to list_path(@item.list)
    end
  end

  def destroy
    logger.debug("Item: #{params}")
  end

  private
    def item_params
      params.require(:item).permit(:description, :status)
    end
end
