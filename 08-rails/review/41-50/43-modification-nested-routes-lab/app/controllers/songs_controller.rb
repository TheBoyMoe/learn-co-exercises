class SongsController < ApplicationController

  # 'songs_path' and 'artist_songs_path'
  # '/songs' and '/artists/:artist_id/songs'
  def index
    # if params[:artist_id]
    #   @artist = Artist.find_by(id: params[:artist_id])
    #   if @artist.nil?
    #     redirect_to artists_path, alert: "Artist not found"
    #   else
    #     @songs = @artist.songs
    #   end
    # else
    #   @songs = Song.all
    # end

    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: 'Artist not found.'
    elsif params[:artist_id]
      artist = Artist.find(params[:artist_id])
      @songs = artist.songs
    else
      @songs = Song.all
    end
  end

  # '/songs/:id' and '/artists/:artist_id/songs/:id'
  def show
    # if params[:artist_id]
    #   @artist = Artist.find_by(id: params[:artist_id])
    #   @song = @artist.songs.find_by(id: params[:id])
    #   if @song.nil?
    #     redirect_to artist_songs_path(@artist), alert: "Song not found"
    #   end
    # else
    #   @song = Song.find(params[:id])
    # end

    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: 'Artist not found.'
    elsif params[:artist_id]
      artist = Artist.find(params[:artist_id])
      if params[:id] && !Song.exists?(params[:id])
        redirect_to artist_songs_path(artist), alert: 'Song not found.'
      else
        @song = artist.songs.find_by(id: params[:id])
      end
    else
      @song = Song.find(params[:id])
    end

  end

  # 'new_songs_path' and 'new_artist_song_path'
  # '/songs/new' and '/artists/:artist_id/songs/:id'
  def new
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: 'Artist not found'
    else
      # assign the :artist_id or nil where not provided
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

  # 'edit_song_path' and 'edit_artist_song_path'
  # '/songs/:id/edit' and '/artists/:artist_id/songs/:id/edit'
  def edit
    # handle the nested route
    if params[:artist_id] && !Artist.exists?(params[:artist_id])
      redirect_to artists_path, alert: 'Artist not found.'
    elsif params[:artist_id]
      artist = Artist.find(params[:artist_id])
      if params[:id] && !Song.exists?(params[:id])
        redirect_to artist_songs_path(artist), alert: 'Song not found.'
      elsif params[:id]
        @nested = true
        @song = artist.songs.find(params[:id])
      end
    # other route
    else
      @nested = false
      @song = Song.find(params[:id])
    end
  end

  def update
    @song = Song.find(params[:id])
    @song.update(song_params)
    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :artist_id)
  end
end

