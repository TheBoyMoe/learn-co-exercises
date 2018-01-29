class GenresController < ApplicationController
	before_action :set_genre, only: [:show, :edit, :update]

	def show
	end

	def new
		@genre = Genre.new
	end

	def create
		@genre = Genre.new(genre_params)
		if @genre.save
			redirect_to genre_path(@genre)
		end
	end

	def edit
	end

	def update
		if @genre.update(genre_params)
			redirect_to genre_path(@genre)
		end
	end

	private
		def set_genre
			@genre = Genre.find(params[:id])
		end

		def genre_params
			params.require(:genre).permit(:name)
		end
end