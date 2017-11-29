Rails.application.routes.draw do

  # nested route to show all songs and individual songs for an artist
  resources :artists do
    resources :songs, only: [:show, :index]
  end
  resources :songs
end
