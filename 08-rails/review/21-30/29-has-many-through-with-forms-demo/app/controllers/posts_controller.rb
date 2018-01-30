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
		byebug
		@post = Post.new(post_params)
		if @post.save
			redirect_to post_path(@post)
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			redirect_to post_path(@post)
		else
			render :edit
		end
	end
	private
		def set_post
			@post = Post.find(params[:id])
		end

		def post_params
			params.require(:post).permit(
					:title,
					:content,
					category_ids: [], # select categories via check boxes
					categories_attributes: [:name] # create new categories associated with the post
			)
		end
end