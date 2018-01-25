class Song < ActiveRecord::Base

	# 'title' can not be repeated by the same artist in the same year
	validates :title, {presence: true, uniqueness: { scope: [:release_year, :artist_name],
											message: "title cannot be repeated by the same artist in the same year" }}
	validates :released, inclusion: {in: [true, false]}
	validates :artist_name, presence: true

	# 'release_year' can not be blank if song has been released
	# and must be less than or equal to the current year
	with_options if: :released? do |song|
		song.validates :release_year, presence: true
		song.validates :release_year, numericality: { less_than_or_equal_to: Time.now.year }
	end

	def released?
		released
	end
end
