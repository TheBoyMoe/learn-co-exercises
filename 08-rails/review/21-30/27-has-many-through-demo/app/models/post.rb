class Post < ApplicationRecord
	has_many :comments
	# a user obviously can comment on many posts, and a post has comments from many users(many-to-many)
	# comments table acts as a 'join' table, any table that contains two
	# foreign keys can be thought of as a join table.
	has_many :users, through: :comments
end