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
		@post = Post.new(title: params[:title], description: params[:description])
		@post.save
		redirect_to post_path(@post)
	end

	def edit
	end

	def update
		if @post.update(title: params[:title], description: params[:description])
			redirect_to post_path(@post)
		else
			render :edit
		end
	end
	private
		def set_post
			@post = Post.find(params[:id])
		end

end