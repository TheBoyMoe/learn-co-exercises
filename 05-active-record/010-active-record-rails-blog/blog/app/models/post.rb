class Post < ApplicationRecord
  # alias the user association as 'author' - aliased association
  # required so that you can alias author_id to User class(rails expects user_id)
  # creates an alias - refer to 'user' as an 'author'
  belongs_to :author, :class_name => 'User'

  has_many :comments
  has_many :commentors, :through => :comments, :source => :commentor
end
