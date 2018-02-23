class RidesController < ApplicationController

	def new
		@ride = Ride.create(
				user_id: params[:user_id],
				attraction_id: params[:attraction_id]
		)
		message_string = @ride.take_ride
		redirect_to user_path(@ride.user_id), notice: message_string
	end
end