class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  # accepts_nested_attributes_for :categories

  def categories_attributes=(category_attributes)
    # hash => {"0" => {"name" => 'category name 1'}, "1" => {"name" => "category_name_2"}}
    category_attributes.values.each do |category_attribute|
      if category_attribute[:name].present? # do not add blank categories
        category = Category.find_or_create_by(name: category_attribute[:name])
        if !self.categories.include?(category) #only add categories to the post which are missing
          self.post_categories.build(category: category)
        end
      end
    end
  end

end
