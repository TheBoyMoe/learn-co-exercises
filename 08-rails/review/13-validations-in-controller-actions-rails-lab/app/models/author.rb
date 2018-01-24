class Author < ActiveRecord::Base
	validates :name, {
			presence: true,
			format: { without: /[0-9]/, message: "does not allow numbers" }
	}
	validates :email, {presence: true, uniqueness: true}
end
