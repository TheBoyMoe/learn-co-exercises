class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    # enable the action to return all the posts for a particular author
    if params[:author_id]
      @posts = Author.find_by(id: params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  def show
    # renders the same information whether it is accessed via /authors/:id/posts/:id or /posts/:id
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
  end

private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :desription, :post_status, :author_id)
  end
end
