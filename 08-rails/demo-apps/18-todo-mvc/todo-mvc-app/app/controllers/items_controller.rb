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

  private
    def item_params
      params.require(:item).permit(:description)
    end
end
