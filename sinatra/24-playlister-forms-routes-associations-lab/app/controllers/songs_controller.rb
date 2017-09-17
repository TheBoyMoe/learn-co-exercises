class SongsController < ApplicationController

  # songs#index action
  get '/songs' do
    @songs = Song.all
    erb :'/songs/index'
  end

  # songs#new action
  get '/songs/new' do
    @genres = Genre.all
    erb :'/songs/new'
  end

  # songs#show action
  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  # songs#create action
  post '/songs' do
    # {
    #   "song"=> {
    #     "name"=>"That One with the Guitar",
    #     "genre_ids"=>["2"]
    #   },
    #   "artist"=> {
    #     "name"=>"Person with a Face"
    #   },
    #   "submit"=>"Create",
    #   "captures"=>[]
    # }
    song = Song.new(name: params[:song][:name])
    params[:song][:genre_ids].each do |id|
      song.genres << Genre.find(id)
    end
    artist = Artist.find_by_slug(params[:artist][:name].gsub(' ', '-').downcase)
    if !artist # not found
      song.artist = Artist.new(name: params[:artist][:name])
    else
      song.artist = artist
    end
    song.save

    flash[:message] = "Successfully created song."
    redirect :"/songs/#{song.slug}"
  end

  # songs#edit action
  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :"/songs/edit"
  end

  # songs#update action
  patch '/songs/:slug' do
    # {
    #   "_method"=>"patch",
    #   "song"=> {
    #     "name"=>"This is the Fourth song that I wrote",
    #     "genre_ids"=>["1", "7", "8"]
    #   },
    #   "artist"=> {
    #     "name"=>"The Beautiful Coast"
    #   },
    #   "save"=>"Save",
    #   "captures"=>[],
    #   "slug"=>"this-is-the-third-song-that-i-wrote"
    # }
    song = Song.find_by_slug(params[:song][:name].gsub(' ', '-').downcase)
    song.genres = params[:song][:genre_ids].collect {|id| Genre.find(id)}
    artist = Artist.find_by_slug(params[:artist][:name].gsub(' ', '-').downcase)
    if !artist # not found
      song.artist = Artist.new(name: params[:artist][:name])
    else
      song.artist = artist
    end
    song.save

    flash[:message] = "Successfully updated song."
    redirect :"/songs/#{song.slug}"
  end

end
