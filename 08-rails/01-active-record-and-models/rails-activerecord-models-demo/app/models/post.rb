class Post < ActiveRecord::Base

  def post_summary
    "#{title}, by #{author}\ndescription - #{description}"
  end
end
