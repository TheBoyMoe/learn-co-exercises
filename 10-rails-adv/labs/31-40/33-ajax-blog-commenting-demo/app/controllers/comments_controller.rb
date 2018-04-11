class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments
     respond_to do |format|
       format.html {render 'index.html', layout: false}
       format.js {render 'index.js', layout: false}
     end
  end

  def create
    @comment = @post.comments.build(comment_params)
    if @comment.save
      render 'comments/show', layout: false
    else
      render 'posts/show'
    end
  end

  private
    def set_post
      @post = Post.find_by(id: params[:post_id])
    end

    def comment_params
      params.require(:comment).permit(:content)
    end
end
