class User < ActiveRecord::Base
  has_many :comments #=> user.comments (all comments by that user)
  has_many :posts, through: :comments #=> user.posts (all posts the user has commented on)
end
