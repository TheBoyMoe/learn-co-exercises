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
		# new form uses form_tag
	  @post = Post.create(title: params[:title], description: params[:description])
	  redirect_to post_path(@post)
	end

	def edit
	end

	def update
	  # edit form utilises form_for
		# @post.update(title: params[:post][:title], description: params[:post][:description])
		@post.update(params.require(:post))
		redirect_to post_path(@post)
	end

	private
		def set_post
			@post = Post.find(params[:id])
		end
end