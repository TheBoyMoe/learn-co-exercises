class Animal
  attr_accessor :name, :kingdom, :phylum, :klass, :order, :family, :genus, :species
  @@all = []

  def initialize
    self.class.all << self
  end

  def self.all
    @@all
  end

  # constructor
  def self.new_from_wikipedia(url)

  end
  
end
