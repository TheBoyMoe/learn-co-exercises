class PostController < ApplicationController

  def index
    # renders default /post/index.html.erb (implicit rendering)

    # instance variables defined in the controller are available in the view
    @posts = Post.all
    render '/post/index'
  end

  def show
    @post = Post.find(params[:id])
    render '/post/show'
  end
end
