class LandmarksController < ApplicationController

  # landmarks#index action
  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  # landmarks#new action
  get '/landmarks/new' do
    erb :'/landmarks/new'
  end

  # landmarks#show action
  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/show'
  end

  # landmarks#create action
  post '/landmarks' do
    # {
    #   "landmark"=> {
    #     "name"=>"Arc de Triomphe",
    #     "year_completed"=>"1806"
    #   },
    #   "submit"=>"Create New Landmark"
    # }
    landmark = Landmark.create(params[:landmark])
    redirect :"/landmarks/#{landmark.id}"
  end

  # landmarks#edit action
  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    erb :'/landmarks/edit'
  end

  # landmarks#create action
  patch '/landmarks/:id' do
    # {
    #   "_method"=>"patch",
    #   "landmark"=> {
    #     "name"=>"Cristopher Columbus",
    #     "year_completed"=>"1896"
    #   },
    #   "save"=>"Edit Landmark",
    #   "id"=>"10"
    # }
    landmark = Landmark.find(params[:id])
    landmark.name = params[:landmark][:name]
    landmark.year_completed = params[:landmark][:year_completed]
    landmark.save

    redirect :"/landmarks/#{landmark.id}"
  end

end
