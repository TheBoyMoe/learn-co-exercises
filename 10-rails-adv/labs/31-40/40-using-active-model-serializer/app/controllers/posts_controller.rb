class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
    render json: @posts, status: 200
  end

  def show
    @post = Post.find(params[:id])

    #BEFORE using a serializer:
    # render json: @post.to_json(only: [:title, :description, :id],
    #                            include: [author: { only: [:name]}])
    
    # AFTER USING OUR SERIALIZER
    # the render call will implicitly use the ActiveModel::Serializer to render the post to json
    render json: @post, status: 200
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.save
    render json: @post, status: 201
  end

  def edit
  end

  def update
    @post.update(post_params)
    render json: @post, status: 202
  end

private
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description)
  end
end
