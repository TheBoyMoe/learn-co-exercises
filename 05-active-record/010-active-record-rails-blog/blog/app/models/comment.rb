class Comment < ApplicationRecord
  belongs_to :commentor, :class_name => 'User', :foreign_key => 'user_id'
  belongs_to :post
end
