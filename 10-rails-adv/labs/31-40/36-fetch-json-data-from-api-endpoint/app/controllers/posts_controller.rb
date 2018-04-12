class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  # one end point that returns structured data representing the blog post
  def post_data
    post = Post.find(params[:id])
    render json: PostSerializer.serialize(post) # render a json string
  end

  # def post_data
  #   post = Post.find(params[:id])
  #   render plain: post.description # render a text string
  # end

private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
