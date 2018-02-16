class ArtistsController < ApplicationController
  def index
    @preference = Preference.last
    if @preference
      @artists = (@preference.artist_sort_order == 'ASC')?
                     Artist.order('name ASC') : Artist.order('name DESC')
    else
      @artists = Artist.all
    end
  end

  def show
    @artist = Artist.find(params[:id])
    @preference = Preference.last
    if @preference
      @songs = (@preference.song_sort_order == 'ASC')?
                   @artist.songs.sort_by {|song| song.title} : @artist.songs.sort_by {|song| song.title}.reverse
    else
      @songs = @artist.songs
    end
  end

  def new
    @preference = Preference.last
    if @preference && @preference.allow_create_artists
      @artist = Artist.new
    else
      flash[:warning] = "You're not allowed to create artists"
      redirect_to artists_path
    end
  end

  def create
    @artist = Artist.new(artist_params)
    if @artist.save
      redirect_to @artist
    else
      render :new
    end
  end

  def edit
    @artist = Artist.find(params[:id])
  end

  def update
    @artist = Artist.find(params[:id])
    @artist.update(artist_params)
    if @artist.save
      redirect_to @artist
    else
      render :edit
    end
  end

  def destroy
    @artist = Artist.find(params[:id])
    @artist.destroy
    flash[:notice] = "Artist deleted."
    redirect_to artists_path
  end

  private

  def artist_params
    params.require(:artist).permit(:name)
  end
end
