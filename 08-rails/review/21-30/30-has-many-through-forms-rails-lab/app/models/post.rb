class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories #=> post.categories (all categories assigned to the post)
  has_many :comments
  has_many :users, through: :comments #=> post.users (all users who have commented on the post)
end
