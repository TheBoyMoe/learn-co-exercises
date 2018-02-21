Rails.application.routes.draw do

  resources :artists do
    resources :songs, only: [:index, :show, :new, :edit]
  end
  #      artists GET       /artists(.:format)                           artists#index
  #              POST      /artists(.:format)                           artists#create
  #   new_artist GET       /artists/new(.:format)                       artists#new
  #  edit_artist GET       /artists/:id/edit(.:format)                  artists#edit
  #       artist GET       /artists/:id(.:format)                       artists#show
  #              PATCH     /artists/:id(.:format)                       artists#update
  #              PUT       /artists/:id(.:format)                       artists#update
  #              DELETE    /artists/:id(.:format)                       artists#destroy

  # nested routes
  # artist_songs GET       /artists/:artist_id/songs(.:format)          songs#index
  #  artist_song GET       /artists/:artist_id/songs/:id(.:format)      songs#show
  # new_artist_song GET    /artists/:artist_id/songs/new(.:format)      songs#new
  # edit_artist_song GET   /artists/:artist_id/songs/:id/edit(.:format) songs#edit


  resources :songs
  #     songs GET    /songs(.:format)                        songs#index
  #           POST   /songs(.:format)                        songs#create
  #  new_song GET    /songs/new(.:format)                    songs#new
  # edit_song GET    /songs/:id/edit(.:format)               songs#edit
  #      song GET    /songs/:id(.:format)                    songs#show
  #           PATCH  /songs/:id(.:format)                    songs#update
  #           PUT    /songs/:id(.:format)                    songs#update
  #           DELETE /songs/:id(.:format)                    songs#destroy

end
