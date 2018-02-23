class AttractionsController < ApplicationController
	before_action :set_attraction, only: [:show, :edit, :update]

	def index
		@attractions = Attraction.all
	end

	def show
	end

	def new
		@attraction = Attraction.new
	end

	def create
		@attraction = Attraction.new(attraction_params)
		if @attraction.save
			redirect_to attraction_path(@attraction), notice: "Attraction added successfully"
		else
			redirect_to new_attraction_path, alert: "Failed to add attraction"
		end
	end

	def edit
	end

	def update
		@attraction.update(attraction_params)
		if @attraction
			redirect_to attraction_path(@attraction), notice: "Update successful"
		else
			redirect_to edit_attraction_path(@attraction), alert: "Update failed"
		end
	end

	private
		def attraction_params
			params.require(:attraction).permit(
		  	 :name,
				 :min_height,
				 :happiness_rating,
				 :nausea_rating,
				 :tickets
			)
		end

		def set_attraction
			@attraction = Attraction.find(params[:id])
		end
end