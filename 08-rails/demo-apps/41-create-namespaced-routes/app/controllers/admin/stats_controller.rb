class Admin::StatsController < ApplicationController

  def index
    # you don't want your views to 'talk' to the db
    @post_count = Post.count
    @authors_count = Author.count
    @last_post = Post.last
  end
end
