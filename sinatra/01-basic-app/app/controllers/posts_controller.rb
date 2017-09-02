# controller should handle one thing, thus use a separate controller for posts, users, categories, tags, etc

# any methods/functionality defined in ApplicationController is automatically available to PostsController
class PostsController < ApplicationController

  get '/posts' do
    "You've reached the posts page"
  end
end
