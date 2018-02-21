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
	  @post = Post.new(set_params)
	  if @post.save
	    redirect_to post_path(@post)
	  else
	    redirect_to :new
	  end
	end

	def update
    @post.update(set_params)
	  redirect_to post_path(@post)
	end

	def edit
	end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def set_params
      params.require(:post).permit(:title, :description)
    end
end
