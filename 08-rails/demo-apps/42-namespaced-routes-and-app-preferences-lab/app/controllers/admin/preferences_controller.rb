class Admin::PreferencesController < ApplicationController

  # only ever creates one preference record in the table, after that simply returns that instance no matter the params values supplied
  def index
    @preference = Preference.first_or_create(allow_create_artists: true, allow_create_songs: true, song_sort_order: "DESC", artist_sort_order: "DESC")
  end

  def update
    @preference = Preference.find(params[:id])
    @preference.update(preference_params)
    flash[:notice] = 'Update successful'
    redirect_to admin_preferences_path
  end

 private
    def preference_params
      params.require(:preference).permit(:allow_create_songs, :allow_create_artists, :song_sort_order, :artist_sort_order)
    end
end
