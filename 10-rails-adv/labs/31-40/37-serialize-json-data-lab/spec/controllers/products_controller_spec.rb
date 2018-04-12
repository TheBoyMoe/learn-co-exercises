require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  before do
    Product.destroy_all
    @product_attributes = {name: "Test", price: "3.99", inventory: 12, description: "This is a great thing"}
  end

  describe "POST create" do

    it 'creates a new product' do
      post :create, product: @product_attributes
      expect(response).to redirect_to(products_path)
      expect(Product.count).to eq 1
    end

  end

  describe "GET inventory" do
    it 'returns true or false appropriately' do
      p1 = Product.create(@product_attributes)
      p2 = Product.create(name: "No Inventory", inventory: 0)
      get :inventory, id: p1.id
      expect(response.body).to eq "true"
      get :inventory, id: p2.id
      expect(response.body).to eq "false"
    end
  end

  describe "GET description" do
    it 'returns the description as a plain string' do
      product = Product.create(@product_attributes)
      get :description, id: product.id
      expect(response.body).to eq product.description
    end
  end

  describe "GET data" do
    it 'returns a JSON representation of the product' do
      product = Product.create(@product_attributes)
      get :data, id: product.id
      body = JSON.parse(response.body)
      expect(body["name"]).to eq product.name
      expect(body["description"]).to eq product.description
      expect(body["inventory"]).to eq product.inventory
    end
  end

end
