module ProductsHelper

  def product_available(product)
    (product.inventory && product.inventory > 0)? "Available":"Sold Out"
  end
end
