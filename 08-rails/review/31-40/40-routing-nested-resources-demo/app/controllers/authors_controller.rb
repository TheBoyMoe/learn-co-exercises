class AuthorsController < ApplicationController

  def show
    @author = Author.find(params[:id])
  end

  # BOTH actions are replaced by using nested routes and routing the
  # request to the appropriate controller in the PostsController

  # 'authors/:id/posts' #=> all posts for that particular user
  # def posts_index
  #   author = Author.find(params[:id])
  #   @posts = author.posts
  #   render 'posts/index'
  # end

  # 'authors/:id/posts/:post_id' #=> retrieve a specific post for user
  # def post
  #   # author = Author.find(params[:id])
  #   # all post_id's are unique, no need to retrieve author first
  #   @post = Post.find(params[:post_id])
  #   render 'posts/show'
  # end

end
