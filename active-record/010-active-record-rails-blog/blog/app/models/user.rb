class User < ApplicationRecord
  # create an alias -> refer to posts as authored_posts
  # requires an alias of the foreign_key, since active record is expecting user_id
  # and the User class has been aliased to author
  has_many :authored_posts, :class_name => 'Post', :foreign_key => :author_id

  has_many :comments
  # since we're aliasing 'posts' as 'commented_posts', set source to 'posts' so active record can see the association
  has_many :commented_posts, :through => :comments, :source => :post

  # NOTE:
  # user can be the creator -> authored_posts, aswell as the participant -> commented posts
  # by using aliasing we're enabling these relationships, since authoured/commented both alias posts
  # using 'posts' in 'has_many' without aliasing would not work
end
