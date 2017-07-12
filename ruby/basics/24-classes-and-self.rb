class Dog
    attr_accessor :name, :breeed, :owner

    def initialize(name, breed)
        @name = name
        @breed = breed
    end

    def adopted(owner)
        # either works
        # self.owner = owner
        @owner = owner
    end

    def to_s
        puts "My name is #{@name}, I'm a #{@breed}"
    end
end

class Owner
    attr_reader :name
    def initialize(name)
        @name = name
    end
end

require 'set'

class Album
    attr_accessor :release_date
    attr_reader :name, :artist, :genre
    # class variables
    @@album_count = 0 
    @@artists = []
    @@genres = []
    @@all = [] # keep track of each album instance

    def initialize(name, artist, genre)
        @name = name
        @artist = artist
        @genre = genre
        @@album_count += 1
        @@artists << artist
        @@genres << genre
        @@all << self
    end

    ## class methods ################
    def self.count
        @@album_count
    end

    def self.all
        @@all.each do |album|
            puts "#{album.name} by #{album.artist}"
        end
        nil
    end

    # return the number of unique artists
    def self.artists
        Set.new(@@artists).to_a
    end

    # return number of unique genres
    def self.genres
        Set.new(@@genres).to_a
    end

    # return a hash displaying number of albums by each artist    
    def self.album_count
        hash = {}
        @@artists.each do |artist|
            hash[artist] = hash[artist] || 0
            hash[artist] += 1
        end
        hash
    end

    # return a hash displaying number of albums per genre
    def self.genre_count
        hash = {}
        @@genres.each do |genre|
            hash[genre] = hash[genre] || 0
            hash[genre] += 1
        end
        hash
    end
end


class Bartender
    attr_accessor :name
    @@bartenders = []

    def initialize(name)
       @name = name 
       @@bartenders << name
    end

    def self.all
        @@bartenders
    end

    def intro
        puts "hi, my name is #{@name}"
    end

    def mix_drink
        @cocktail = []
        choose_liquor
        choose_mixer
        choose_garnish
        puts "Here's your drink, it contains #{@cocktail}"
    end

    private # makes all subsequent methods private - only accessible from within the class
    def choose_liquor
        @cocktail << 'Whiskey'
    end

    def choose_mixer
        @cocktail << 'Vermouth'
    end

    def choose_garnish
        @cocktail << 'Olives'
    end

end
