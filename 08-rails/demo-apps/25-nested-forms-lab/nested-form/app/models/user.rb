class User < ApplicationRecord
  has_many :addresses
  belongs_to :team

  # rails helper method which adds #addresses_attributes= method
  # accepts_nested_attributes_for :addresses

  # or you can define it manually when you have complex nested forms
  def addresses_attributes=(addresses_attributes)
    # address_attributes = [
    #   {:street_1 => 'The street', :address_type => 'Home'},
    #   {:street_1 => 'The second street', :address_type => 'Business'}
    # ]

    addresses_attributes.each do |address_attributes|
      self.addresses.build(address_attributes)
    end
  end
end
