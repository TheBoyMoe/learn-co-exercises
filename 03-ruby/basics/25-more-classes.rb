require 'pry'
require 'nokogiri'
require 'open-uri'

class Concert
    attr_accessor :venue, :name, :location
    # class variable - in scope in both class & instance methods
    @@all = [] 

    # constructor - extends initialize's functionality
    def self.create
        concert = self.new # calls initialize
        concert.save
        concert
    end

    # extend the functionality ofconstructor further
    def self.new_from_seatgeek(url)
        doc = Nokogiri::HTML(open(url))
        hash = {}
        hash[:name] = doc.search("#event-title").text
        hash[:venue] = doc.search(".event-detail-words").text.split(' - ').first
        self.new_from_hash(hash)
    end

    # constructor #=> hash = {venue: 'MSG', location: 'NYC'}
    def self.new_from_hash(hash)
        concert = self.new
        concert.name = hash[:name]
        concert.location = hash[:location]
        concert.venue = hash[:venue]
        concert    
    end

    # initialize is closed for modification - carries out default behaviour
    def initialize
        #instance scope, self refers to the instance
    end

    def save
        @@all << self
    end

    # class reader
    def self.all
        # class scope
        @@all
    end

    def over?
        # instance scope - in the context of an instance method,
        # self referes to an instance of the class
        Time.now - self.date <= 0
    end

    # Class finder - returns data
    def self.find_by_location(location)
        # class scope - in the context of a class method,
        # self referes to the class
        self.all.detect {|concert| concert.location == location}
    end

    def self.find_all_by_location(location)
        self.all.select {|concert| concert.location == location}
    end

    def self.destroy_all
        self.all.clear
    end

end

# carlin = Concert.new
# carlin.venue = 'Beacon Theatre'
# carlin.location = 'NYC'
# carlin.name = 'George Carlin'

# sting = Concert.new
# sting.venue = 'The Greek Theatre'
# sting.location = 'LA'
# sting.name = 'Sting'

# diamond = Concert.new
# diamond.location = 'NYC'
# diamond.venue = 'Madison Square Garden'
# diamond.name = 'Neil Diamond'

binding.pry
