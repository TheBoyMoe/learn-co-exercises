class StoreAdminController < ApplicationController

  # render admin.html.erb as the default action for all StoreAdminController actions
  layout 'admin'

  def home
    # renders the admin layout with the home template
  end

  def orders
    # render the order_administration.html.erb layout with the orders template
    render :layout => 'order_administration'
  end

  def invoice
    # render without using any layout, only the oinvoice template
    render :layout => false
  end

end
