class Person < ActiveRecord::Base
  has_many :addresses
  # adds #addresses_attributes method to the person sinstance
  accepts_nested_attributes_for :addresses
end
