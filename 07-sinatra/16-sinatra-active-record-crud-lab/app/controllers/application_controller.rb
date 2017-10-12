require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect :'/posts'
  end


  # CREATE GET posts#new action --> allow the user to create a new post
  get '/posts/new' do
    erb :new
  end

  # CREATE POST posts#create action --> add the new post to the database
  post '/posts' do
    Post.create(name: params[:name], content: params[:content])

    #redirect :"/posts/#{post.id}"
    redirect :'/posts'
  end

  # READ GET posts#index action --> list all posts
  get '/posts' do
    @posts = Post.all

    erb :index
  end

  # READ GET posts#show action --> show an individual post
  get '/posts/:id' do
    @post = Post.find(params[:id])

    erb :show
  end

  # EDIT GET posts#edit action --> render a view allowing the user to edit te particular model instance
  get '/posts/:id/edit' do
    @post = Post.find(params[:id])

    erb :edit
  end

  # EDIT PATCH posts#update action --> save the updated instance
  patch '/posts/:id' do
    post = Post.find(params[:id])
    post.name = params[:name]
    post.content = params[:content]
    post.save

    redirect :"/posts/#{post.id}"
  end

  # DELETE POST posts#destroy
  delete '/posts/:id/delete' do
    @post = Post.find(params[:id])
    @post.destroy

    erb :delete
  end

end
