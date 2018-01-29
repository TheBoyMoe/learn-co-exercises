class AuthorsController < ApplicationController
  # before_action :set_author, only: [:show, :posts_index, :post]
  before_action :set_author, only: [:show]

  def show
  end

  # #post and #posts_index are handled by nested routes in posts controller

  # additional routes
  # def posts_index
  #   @posts = @author.posts
  #   # explicitly tell rails the template we wish to be rendered
  #   render template: 'posts/index'
  # end

  # def post
  #   # DOES NOT return the specific authors post
  #   # @post = Post.find_by(id: params[:post_id])
  #
  #   @post = @author.posts.find_by(id: params[:post_id])
  #   render template: 'posts/show'
  # end

  private
    def set_author
      @author = Author.find_by(id: params[:id])
    end
end
