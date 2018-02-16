class Admin::StatsController < ApplicationController

  def index
    @post_count = Post.count
    @authors_count = Author.count
    @last_post = Post.last
  end

  def new
  end

  def show
  end

  def edit
  end
end
