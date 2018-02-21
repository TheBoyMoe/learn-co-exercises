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

    # addresses_attributes.each do |address_attributes|
    #   self.addresses.build(address_attributes)
    # end

    # WHEN USING #fields_for helper method - you get a hash of hashes
    # address_attributes = {
    #   0 => {:street_1 => 'The street', :address_type => 'Home'},
    #   1 => {:street_1 => 'The second street', :address_type => 'Business'}
    # }

    addresses_attributes.values.each do |address_attributes|
      self.addresses.build(address_attributes)
    end
  end

  # def team_name=(name)
  #   #find team by name
  #   self.team = Team.find_by(name: name)
  # end

  def team_attributes=(team_attributes)
    # create a team by name and set attributes
    # team_attributes = {
    #   :name => 'New Team Name',
    #   :hometown => 'NYC'
    # }
    self.team = Team.where(:name => team_attributes[:name]).first_or_create do |t|
      t.hometown = team_attributes[:hometown]
    end
  end

end
