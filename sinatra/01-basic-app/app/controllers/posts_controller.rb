# controller should handle one thing, thus use a separate controller for posts, users, categories, tags, etc

# the view has access to all of the instance variables defined in the instance controller
# but that instance variable is only available within the controller where it's defined

# Each controller should handle ONE resource and should
# implement these 7 actions (follows the design pattern described by Roy Fielding)
# 1. posts#index action #=> show all items
# 2. posts#show action #=> show item
# 3. posts#new action #=> allow user to create new item
# 4. posts#create action => add new item
# 5. posts#edit action => allow user to edit item
# 6. posts#update action #=> update item
# 7. posts#destroy action #=> delete item

# Order of your actions matter, have more specific actions appear before more generic ones, e.g 'post#new' before 'posts#id'

# we create dynamic routes using route variables - any variable starting with ':'
# :id is a route variable -> way of passing a dynamic variable into your route
# anything following '?' is part of the query string and (texhnically) not part of the url
# (you can retrieve query string values from the params hash via their keys.)

# all data submitted by a user will appear in params - weather it was submitted via
# a url route variables, query parameters, form submission, etc. Route variables & query parameters end up as keys
# any methods/functionality defined in ApplicationController is automatically available to PostsController


class PostsController < ApplicationController

  # posts#index action
  get '/posts' do
    @posts = Post.all
    # the name of the view matches that of the action
    erb :'posts/index'
  end

  # posts#new action
  get '/posts/new' do
    # render page that allows user to create a post
    erb :'posts/new'
  end

  # posts#show action
  get '/posts/:id' do
    # raise params.inspect #=> view the params entered by the user
    @post = Post.find(params[:id])

    erb :'posts/show'
  end

  # action called by submitting the form
  # posts#create action
  post '/posts' do
    # raise params.inspect #=> debug

    # @post = Post.new
    # @post.title = params[:title_field]
    # @post.content = params[:content_field]

    # if you use mass-assignment(via params hash) the name attribute values in
    # your form MUST match the names of your property attributes defined in your migrations
    @post = Post.new(params)
    @post.save

    redirect "/posts/#{@post.id}"
  end

  # posts#edit action


  # posts#update action


  # posts#destroy action





  # 'custom' route
  # order of your routes matters, put more specific routes before generic ones
  get '/posts/favorites' do
    # posts with id 2 and 3 are my favorites
    # how do I load only posts 2 and 3?
    # @favorites = Post.where(:id => [2,3])
    @favorites = Post.find([2,3])

    erb :"posts/favorites"
  end

end
