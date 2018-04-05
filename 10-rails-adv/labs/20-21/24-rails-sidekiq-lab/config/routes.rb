Rails.application.routes.draw do
  resources :artists, :songs
  post 'songs/upload', to: 'songs#upload'
  root to: 'customers#index'
end
