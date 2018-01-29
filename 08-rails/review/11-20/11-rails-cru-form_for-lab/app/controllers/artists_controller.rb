class ArtistsController < ApplicationController
	before_action :set_artist, only: [:show, :edit, :update]

	def show
	end

	def new
		@artist = Artist.new
	end

	def create
		@artist = Artist.new(artist_params)
		if @artist.save
			redirect_to artist_path(@artist)
		end
	end

	def edit
	end

	def update
		if @artist.update(artist_params)
			redirect_to artist_path(@artist)
		end
	end

	private
		def set_artist
			@artist = Artist.find(params[:id])
		end

		def artist_params
			params.require(:artist).permit(:name, :bio)
		end
end