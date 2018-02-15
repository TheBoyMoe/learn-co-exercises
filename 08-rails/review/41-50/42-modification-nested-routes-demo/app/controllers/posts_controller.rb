class PostsController < ApplicationController

  # '/posts' and '/authors/:author_id/posts'
  def index
    if params[:author_id]
      @posts = Author.find(params[:author_id]).posts
    else
      @posts = Post.all
    end
  end

  # '/posts/:id' and '/authors/:author_id/posts/:id'
  def show
    if params[:author_id]
      @post = Author.find(params[:author_id]).posts.find(params[:id])
    else
      @post = Post.find(params[:id])
    end
  end

  # '/posts/new' and '/authors/:author_id/posts/new'
  def new
    # check that the author exists
    if params[:author_id] && !Author.exists?(params[:author_id])
      redirect_to authors_path, alert: 'Author not found.'
    else
      # for '/posts/new' => author_id initialized as nil
      # => we could simply eliminate the route
      @post = Post.new(author_id: params[:author_id])
    end
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to post_path(@post)
  end

  def edit
    if params[:author_id]
      author = Author.find_by(id: params[:author_id])
      # check that we have a valid author
      if author.nil?
        redirect_to authors_path, alert: 'Author not found'
      else
        # and search for the post amongst the author's posts
        # ensures that someone is not trying to pass spurious values through the address bar
        @post = author.posts.find_by(id: params[:id])
        redirect_to author_posts_path(author), alert: 'Post not found' if @post.nil?
      end
    else
      @post = Post.find(params[:id])
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(params.require(:post))
    redirect_to post_path(@post)
  end

  private
    def post_params
      params.require(:post).permit(:title, :description, :author_id)
    end

end
