class Comment < ActiveRecord::Base
  belongs_to :user #=> comment.user
  belongs_to :post #=> comment.post

  # TODO
  # - you can add blank comments
  # - throws exception if no user specfied
  # - you can create duplicate users
  accepts_nested_attributes_for :user, reject_if: :all_blank
end
