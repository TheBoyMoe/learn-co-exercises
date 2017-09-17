class FiguresController < ApplicationController

  # figures#index action
  get '/figures' do
    erb :'/figures/index'
  end

  # figures#new action
  get '/figures/new' do
    erb :'/figures/new'
  end

  # figures#show action
  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  # figures#create action
  post '/figures' do
    # {
    #   "figure"=> {
    #     "name"=>"new Historical figure",
    #     "landmark_ids"=>["1", "2", "8"],
    #     "title_ids"=>["3"]
    #   },
    #   "landmark"=> {
    #     "name"=>"landmark name"
    #   },
    #   "title"=>{
    #     "name"=>"title name"
    #   },
    #   "submit"=>"Create New Figure"
    # }
    figure = Figure.new(name: params[:figure][:name])

    if params[:figure][:landmark_ids] # returns nil if no checkboxes selected
      figure.landmarks = params[:figure][:landmark_ids].collect {|id| Landmark.find(id)}
    end

    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.new(name: params[:landmark][:name])
    end

    if params[:figure][:title_ids] # returns nil if no checkboxes selected
      figure.titles = params[:figure][:title_ids].collect {|id| Title.find(id)}
    end

    if !params[:title][:name].empty?
      figure.titles << Title.new(name: params[:title][:name])
    end

    figure.save
    redirect :'/figures'
  end

  # figures#edit action
  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  # figures#update action
  patch '/figures/:id' do
    figure = Figure.find(params[:id])

    if !params[:figure][:name].empty?
      figure.name = params[:figure][:name]
    end

    if params[:figure][:landmark_ids] # returns nil if no checkboxes selected
      figure.landmarks = params[:figure][:landmark_ids].collect {|id| Landmark.find(id)}
    end

    if !params[:landmark][:name].empty?
      figure.landmarks << Landmark.new(name: params[:landmark][:name])
    end

    if params[:figure][:title_ids] # returns nil if no checkboxes selected
      figure.titles = params[:figure][:title_ids].collect {|id| Title.find(id)}
    end

    if !params[:title][:name].empty?
      figure.titles << Title.new(name: params[:title][:name])
    end

    figure.save

    redirect :"/figures/#{figure.id}"
  end

end
