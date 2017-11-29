class SongsController < ApplicationController
  before_action :set_song, only: [:edit, :update, :destroy]

  def index
    if params[:artist_id]
      artist = Artist.find_by(id: params[:artist_id])
      if artist
        @songs = artist.songs
      else
        flash[:alert] = "Artist not found"
        redirect_to artists_path
      end
    else
      @songs = Song.all
    end
  end

  def show
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      @song = @artist.songs.find_by(id: params[:id])
      if !@song
        flash[:alert] = "Song not found"
        redirect_to artist_songs_path(@artist)
      end
    else
      set_song
    end
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

  private
    def set_song
      @song = Song.find(params[:id])
    end

    def song_params
      params.require(:song).permit(:title, :artist_name)
    end
end
