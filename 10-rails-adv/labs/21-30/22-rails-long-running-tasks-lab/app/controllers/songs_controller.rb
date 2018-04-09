class SongsController < ApplicationController
  before_action :set_song, only: [:show, :edit, :update, :destroy]
  require 'csv'

  def index
    @songs = Song.all
  end

  def show
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)
    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
  end

  def update
    @song.update(song_params)
    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  def upload
    CSV.foreach(params[:file].path, headers: true) do |song|
      Song.create(title: song[0], artist_name: song[1])
    end
    redirect_to songs_path
  end

  private
    def song_params
      params.require(:song).permit(:title, :artist_name)
    end

    def set_song
      @song = Song.find(params[:id])
    end
end

