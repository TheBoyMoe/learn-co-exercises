class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
		@posts = Post.all
	end

	def show
		@category = @post.category
	end

	def new
		@post = Post.new
		@categories = Category.all
	end

	def create
		post = Post.create(params[:post])
		redirect_to post_path(post)
	end

	def edit
		@categories = Category.all
	end

	def update
		@post.update(params.require(:post))
		redirect_to post_path(@post)
	end

	def destroy
		@post.destroy
		redirect_to posts_path
	end

	private
		def set_post
			@post = Post.find(params[:id])
		end
end
