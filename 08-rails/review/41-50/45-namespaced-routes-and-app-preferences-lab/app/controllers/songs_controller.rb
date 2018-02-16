class SongsController < ApplicationController

  def index
    if params[:artist_id]
      @artist = Artist.find_by(id: params[:artist_id])
      if @artist.nil?
        redirect_to artists_path, alert: "Artist not found"
      else
        sort_artist_songs
      end
    else
      sort_all_songs
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
    @preference = Preference.last
    if @preference && @preference.allow_create_songs
      @song = Song.new
    else
      flash[:notice] = "You're not allowed to create a new song"
      redirect_to songs_path
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
    @song = Song.find(params[:id])
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
    params.require(:song).permit(:title, :artist_name)
  end

  def sort_artist_songs
    @preference = Preference.last
    if @preference
      @songs = (@preference.song_sort_order == 'ASC')?
                   @artist.songs.sort_by {|song| song.title} : @artist.songs.sort_by {|song| song.title}.reverse
    else
      @songs = @artist.songs
    end
  end

  def sort_all_songs
    @preference = Preference.last
    if @preference
      @songs = (@preference.song_sort_order == 'ASC')?
                   Song.order('title ASC') : Song.order('title DESC')
    else
      @songs = Song.all
    end
  end
end

