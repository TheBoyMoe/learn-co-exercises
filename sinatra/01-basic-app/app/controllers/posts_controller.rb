# controller should handle one thing, thus use a separate controller for posts, users, categories, tags, etc

# any methods/functionality defined in ApplicationController is automatically available to PostsController
class PostsController < ApplicationController

  # the view has access to all of the instance variables defined in the instance controller
  # but that instance variable is only available within the controller where it's defined

  # posts#index action
  get '/posts' do
    @posts = Post.all
    erb :'posts/index'
  end

  # order of your routes matters, put more specific routes before generic ones
  get '/posts/favorites' do
    # posts with id 2 and 3 are my favorites
    # how do I load only posts 2 and 3?
    # @favorites = Post.where(:id => [2,3])
    @favorites = Post.find([2,3])

    erb :"posts/favorites"
  end

  # posts#show (dynamic route to fetch a particular post)
  get '/posts/:id' do
    @post = Post.find(params[:id])

    erb :'posts/show'
  end



end
