class Concert
  attr_accessor :venue, :name, :location
  @@all = [] #=> class variable - in scope in class & instance methods
  # ALL = [] #=> class constant - you can use it instead of @@all - but can cause leaky inheritence

  def initialize # instance method - since the receiver is the instance
  end

  #constructor
  def self.create
    concert = self.new
    concert.save # save an instance of the instance
    concert
  end

  # {:name => 'Frank Sinatra', :venue => 'Madison Square Garden', :location => 'NYC'}
  # {name: 'Neil Diamond', venue: 'The Greek Theatre', location: 'LA'}

  # constructor
  def self.new_from_hash(hash)
    c = self.create
    c.name = hash[:name]
    c.venue = hash[:venue]
    c.location = hash[:location]
    c
  end

  def save
    self.class.all << self
  end

  def destroy_all
    self.class.all.clear
  end

  def self.all #=> class reader
    @@all
  end

  # return the first concert that matches, or nil
  def self.find_by_location(location)
    self.all.detect {|c| c.location == location}
  end

  # return all matches, or [] - use #find_all or #select
  def self.find_all_by_location(location)
    self.all.find_all {|c| c.location == location}
  end

end

Concert.find_by_location('NYC') #=> [#<Concert>, #<Concert>]
