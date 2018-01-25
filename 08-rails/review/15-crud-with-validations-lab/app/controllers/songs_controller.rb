class SongsController < ApplicationController
	before_action :set_song, only: [:show, :edit, :update, :destroy]

	def index
		@songs = Song.all
	end

	def show
	end

	def new
		@song = Song.new
	end

	def create

	end

	def edit
	end

	def update

	end

	def destroy

	end
end