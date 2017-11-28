class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  #  THE METHODS MUST RETURN AN ACTIVE RECORD RELATION OBJECT

  # returns the 1st five boats
  def self.first_five
    Boat.all.limit(5)
  end

  # returns boats shorter than 20 feet
  def self.dinghy
    Boat.where("length < ?", 20)
  end

  # returns boats >= 20 feet
  def self.ship
    Boat.where("length >= ?", 20)
  end

  # returns last three boats in alphabetical order
  def self.last_three_alphabetically
    Boat.order('name desc').limit(3)
  end

  # returns boats without a captain
  def self.without_a_captain
    Boat.where('captain_id IS NULL')
  end

  # returns all boats that are sailboats
  def self.sailboats
    Boat.includes(:classifications).where(classifications: {name: 'Sailboat'})
  end

  # returns boats with three classifications
  def self.with_three_classifications
    Boat.joins(:classifications).group("boats.id").having("COUNT(*) = 3").select("boats.*")
  end

  def self.longest
    Boat.order('length DESC').first
  end
end
