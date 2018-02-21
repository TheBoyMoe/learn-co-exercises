class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]

  # make available a controller method in the view - SHOULDN'T do this
  # you shouldn't expose params to the views, params should only be read by controllers
  # helper_method :params


  def index
    # provide a list of authors to the index view
    @authors = Author.all
    # filter posts based on user selection - refactored methods - moved to model
    if !params[:author].blank?
      #  @posts = Post.where(author: params[:author])
      @posts = Post.by_author(params[:author])
    elsif !params[:date].blank?
      if params[:date] == "Today"
        # @posts = Post.where("created_at >=?", Time.zone.today.beginning_of_day)
        @posts = Post.from_today
      else
        # @posts = Post.where("created_at <?", Time.zone.today.beginning_of_day)
        @posts = Post.old_news
      end
    else
      # if no filters are applied, show all posts
      @posts = Post.all
    end
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(params)
    @post.save
    redirect_to post_path(@post)
  end

  def edit
  end

  def update
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end


  private
    def set_post
      @post = Post.find(params[:id])
    end
end
