class SongsController < ApplicationController
  before_action :set_song, only: [:update, :destroy]

  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        @songs = @artist.songs
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if @song.nil?
        redirect_to artist_songs_path(@artist), alert: "Song not found"
      end
    else
      @song = Song.find(params[:id])
    end
  end

  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id]) # ?valid artist
      redirect_to artists_path, alert: 'Artist not found'
    else
      @song = Song.new(artist_id: params[:artist_id])
    end
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
    if params[:artist_id]
      @nested = true
      artist = Artist.find_by(id: params[:artist_id]) # ?valid artist
      if artist
        @song = artist.songs.find_by(id: params[:id]) # song is in the artists song collection
        redirect_to artist_songs_path(artist), alert: 'Song not found' if @song.nil?
      else
        redirect_to artists_path, alert: 'Artist not found'
      end
    else
      set_song
    end
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

  private
    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:title, :artist_name, :artist_id)
    end
end
