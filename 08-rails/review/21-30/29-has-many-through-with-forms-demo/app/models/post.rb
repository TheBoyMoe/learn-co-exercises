class Post < ApplicationRecord
	has_many :post_categories
	has_many :categories, through: :post_categories

	# enable creating new categories as nested attributes of the post model
	accepts_nested_attributes_for :categories

	# override categories_attributes= method so duplicates can not be defined NOT CASE SENSITIVE
	def categories_attributes=(category_attributes)
		category_attributes.values.each do |category_attribute|
			if category_attribute[:name].present? # do not add blank categories
				category = Category.find_or_create_by(name: category_attribute[:name])
				unless self.categories.include?(category) #only add categories to the post which are missing
					self.post_categories.build(category: category)
				end
			end
		end
	end
end
