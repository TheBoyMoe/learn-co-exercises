class PostsController < ApplicationController

  get '/posts' do
    erb :'posts/index'
  end

  get '/posts/new' do
    # if the user is not logged in
    # binding.pry # DEBUG
    if !logged_in?
      # redirect them to '/login'
      redirect :'/login'
    else
      # otherwise render the 'new' post page
      erb :'posts/new'
    end
  end

  # ensure that only logged in users can edit a post
  get '/posts/:id/edit' do
    if !logged_in?
      redirect :'/login'
    else
      # retrieve the post
      @post = Post.find(params[:id])
      # display the post if the current_user is it's author
      if current_user.id == @post.user_id
        # render the post
        erb :'posts/edit'
      else
        # redirect :'/posts'
        @message = "You don't have permissions to edit the post"
        erb :'posts/error'
      end
    end
  end

end
