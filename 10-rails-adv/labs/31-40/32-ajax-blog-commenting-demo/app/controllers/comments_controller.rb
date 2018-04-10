class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments

    # ensure that the response to the ajax request is only the content and does not include the layout file
    render 'comments/index', layout: false
  end

  private
    def set_post
      @post = Post.find_by(id: params[:post_id])
    end
end
