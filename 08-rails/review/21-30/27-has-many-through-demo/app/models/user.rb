class User < ApplicationRecord
	has_many :comments
	# we can't just declare that our User 'has_many :posts' because our posts
	# table doesn't have a 'foreign key' called 'user_id'
	# - the post does not belong to the user
	# calling 'user.posts' will return an array of posts the user has commented on
	has_many :posts, through: :comments
end