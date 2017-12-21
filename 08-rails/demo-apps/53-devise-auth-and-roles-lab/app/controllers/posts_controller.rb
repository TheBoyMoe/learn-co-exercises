class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to posts_url

    # ALTERNATE
    # user_id = current_user.id
    # Post.create(
    #     content: params[:post][:content],
    #     user_id: user_id
    # )
    # redirect_to user_path(id: user_id)
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to posts_url(@post)
  end

  def show
  end

  def destroy
    @post.destroy
    flash[:notice] = "Successfully deleted post"
    redirect_to posts_url
  end

  private
    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :user_id)
    end

    def authorize_user
      unless current_user == @post.user || current_user.vip? || current_user.admin?
        flash[:alert] = "Unauthorized access!"
        redirect_to post_path(@post)
      end
    end
end
