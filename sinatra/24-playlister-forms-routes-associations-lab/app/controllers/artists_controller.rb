class ArtistsController <ApplicationController

  # artists#index action
  get '/artists' do
    @artists = Artist.all
    erb :'/artists/index'
  end

  # artists#show action
  get '/artists/:slug' do
    @artist = Artist.find_by_slug(params[:slug])
    erb :'/artists/show'
  end

end
