class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price, :inventory, :price
  has_many :orders
end
