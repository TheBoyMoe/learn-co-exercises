class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments
  end

  private
    def set_post
      @post = Post.find_by(id: params[:post_id])
    end
end
