class PostsController < ApplicationController

  def index
    # '/authors/:author_id/posts'
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      # '/posts'
      @posts = Post.all
    end
  end

  def show
    # '/authors/:author_id/posts/:id' and '/posts/:id'
    @post = Post.find(params[:id])
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
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def edit
    @post = Post.find(params[:id])
  end

private

  def post_params
    params.require(:post).permit(:title, :desription, :post_status, :author_id)
  end
end
