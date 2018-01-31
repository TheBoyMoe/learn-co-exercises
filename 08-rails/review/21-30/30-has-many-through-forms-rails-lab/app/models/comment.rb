class Comment < ActiveRecord::Base
  belongs_to :user #=> comment.user
  belongs_to :post #=> comment.post

  accepts_nested_attributes_for :user, reject_if: :all_blank
end
