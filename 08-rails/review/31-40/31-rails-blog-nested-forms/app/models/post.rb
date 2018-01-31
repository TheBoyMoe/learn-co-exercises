class Post < ActiveRecord::Base
  belongs_to :user #=> post.user
  has_many :comments #=> post.comments
  has_many :post_tags
  has_many :tags, through: :post_tags #=> post.tags

  validates_presence_of :name, :content
end
