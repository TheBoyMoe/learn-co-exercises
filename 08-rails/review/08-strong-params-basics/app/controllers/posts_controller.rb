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
	  # @post = Post.new(params[:post])
	  @post = Post.new(params.require(:post).permit(:title, :description))
		@post.save
	  redirect_to post_path(@post)
	end

	def update
		# params hash: 'post' => {title: '', description: ''}
		# 'hacking' the edit form and adding a description field does not work if you
		# specify the particular attribute 'update' accepts, e.g
		# @post.update(title: params[:post][:title])

		# works when you use mass-assignment & add `config.action_controller.permit_all_parameters = true`
		# to config/application.rb
		# @post.update(params[:post])

		# Rails needs to be told what parameters are allowed to be submitted through the
		# form to the database. The default is to let nothing through - strong params
		# `require` - params hash must have the key - 'post'
		# `permit` - params hash can haev any other keys, only 'title' will be accepted
	  @post.update(params.require(:post).permit(:title))

		redirect_to post_path(@post)
	end

	def edit
	end


	private
		def set_post
			@post = Post.find(params[:id])
		end

		def post_params
			# 'dry' out the 'create' and 'update' methods
			params.require(:post).permit(:title, :description)
		end
end
