class Comment < ActiveRecord::Base
  belongs_to :user #=> comment.user
  belongs_to :post #=> comment.post
end
