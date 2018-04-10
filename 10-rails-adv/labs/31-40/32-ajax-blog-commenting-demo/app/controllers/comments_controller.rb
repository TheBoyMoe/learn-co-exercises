class CommentsController < ApplicationController

  def index
    @post = Post.find_by(id: params[:post_id])
    @comments = @post.comments
  end

end
