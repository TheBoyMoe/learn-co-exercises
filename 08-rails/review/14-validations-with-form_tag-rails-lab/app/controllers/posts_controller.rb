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

  end

  def edit
  end

  def update

    @post.update(post_params)

    redirect_to post_path(@post)
  end

  private
    def post_params
      params.permit(:title, :category, :content)
    end

    def set_post
      @post = Post.find(params[:id])
    end
end
