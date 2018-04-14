class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @post}
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    # redirect_to post_path(@post)

    # use the serializer to return json
    render json: @post, status: 201 # resource created
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def post_data
    post = Post.find(params[:id])
    #render json: PostSerializer.serialize(post)
    render json: post.to_json(only: [:title, :description, :id],
                              include: [author: { only: [:name]}])
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :description)
    end
end
