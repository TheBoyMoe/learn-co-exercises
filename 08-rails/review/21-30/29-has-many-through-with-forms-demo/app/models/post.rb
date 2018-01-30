class Post < ApplicationRecord
	has_many :post_categories
	has_many :categories, through: :post_categories

	# enable creating new categories as nested attributes of the post model
	accepts_nested_attributes_for :categories
end
