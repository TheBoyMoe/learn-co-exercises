class Address < ApplicationRecord
	# don't forget to add 'person_id' column to Address model
	has_one :person
end
