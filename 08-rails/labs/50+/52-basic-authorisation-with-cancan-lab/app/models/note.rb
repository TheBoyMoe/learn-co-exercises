class Note < ActiveRecord::Base
	belongs_to :user
	has_many :viewers
	has_many :readers, through: :viewers, source: :user

	before_save :ensure_owner_can_read

	def visible_to
		readers.map do |user|
			user.name
		end.join(', ')
	end

	# give read status to other users
	def visible_to=(names)

		# names.split(',').each do |name|
		# 	user = User.find_by(name: name.strip)
		# 	readers << user unless readers.include? user
		# end

		self.readers = names.split(',').map do |name|
			User.find_by(name: name.strip)
		end.compact
	end

	private
		def ensure_owner_can_read
			if user && !readers.include?(user)
				readers << user
			end
		end
end
