class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect :'/recipes/index'
  end

  # recipes#index action
  get '/recipes' do
    @recipes = Recipe.all

    erb :'recipes/index'
  end

  # resipes#new action
  get '/recipes/new' do
    erb :'recipes/new'
  end

  # recipes#create action
  post '/recipes' do
    # create and save the recipe instance
    recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])

    redirect :"/recipes/#{recipe.id}"
  end

  # recipes#show action
  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])

    erb :'recipes/show'
  end

  # recipes#delete action
  delete '/recipes/:id/delete' do
    recipe = Recipe.find(params[:id])
    recipe.delete

    redirect :'/recipes'
  end

  # recipes#edit action
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])

    erb :'/recipes/edit'
  end

  # recipes#update action
  patch '/recipes/:id' do
    recipe = Recipe.find(params[:id])
    recipe.name = params[:name]
    recipe.ingredients = params[:ingredients]
    recipe.cook_time = params[:cook_time]
    recipe.save

    redirect :"/recipes/#{recipe.id}"
  end



end
