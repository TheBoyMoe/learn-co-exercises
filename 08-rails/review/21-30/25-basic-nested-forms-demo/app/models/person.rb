class Person < ApplicationRecord
	has_many :addresses

	# responsible for processing the address_attributes
	# hash found in the person hash submitted by new.html.erb
	#  - generates the `addresses_attributes=` method
	accepts_nested_attributes_for :addresses
end
