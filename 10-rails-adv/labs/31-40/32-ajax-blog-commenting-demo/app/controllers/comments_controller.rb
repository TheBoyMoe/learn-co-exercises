class CommentsController < ApplicationController
  before_action :set_post

  def index
    @comments = @post.comments
    # ensure that the response to the ajax request is only the content and does not include the layout file
    # render 'comments/index', layout: false # responds with html
    
    # render json: @comments # response in json
    
    # action renders index.html view or index.js if requested
    # render layout: false # or render 'index.js', layout: false

    # respond to either html/js requests - this is implicit in Rails
    # ALL YOU NEED in 'render layout: false' in this example
    # here you're stating it explicitly, allowing you to render other views
    respond_to do |format|
      format.html {render 'index.html', layout: false}
      format.js {render 'index.js', layout: false}
    end
  end

  private
    def set_post
      @post = Post.find_by(id: params[:post_id])
    end
end
