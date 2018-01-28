class Post < ApplicationRecord
  belongs_to :category

  # called when ever Post is initialized with a 'category_name' field, 'posts#create'
  def category_name=(name)
    self.category = Category.find_or_create_by(name: name)
  end

  def category_name
    self.category.name if self.category
  end
end
