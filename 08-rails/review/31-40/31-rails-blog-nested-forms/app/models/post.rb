class Post < ActiveRecord::Base
  belongs_to :user #=> post.user
  has_many :comments #=> post.comments
  has_many :post_tags
  has_many :tags, through: :post_tags #=> post.tags

  validates_presence_of :name, :content

  accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }
end
