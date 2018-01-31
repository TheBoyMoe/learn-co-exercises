class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories #=> category.posts (all posts with that particular category)
end
