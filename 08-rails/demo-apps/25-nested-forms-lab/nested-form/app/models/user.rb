class User < ApplicationRecord
  has_many :addresses
  belongs_to :team

  def address_attributes=(addresses_attributes)
    # address_attributes = [
    #   {:street_1 => 'The street', :address_type => 'Home'},
    #   {:street_1 => 'The second street', :address_type => 'Business'}
    # ]

    addresses_attributes.each_char do |address_attributes|
      self.addresses.build(address_attributes)
    end
  end
end
