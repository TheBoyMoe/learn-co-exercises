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

    def initialize(name, artist, genre)
        @name = name
        @artist = artist
        @genre = genre
        @@album_count += 1
        @@artists << artist
        @@genres << genre
    end

    # class method
    def self.count
        @@album_count
    end

    # class method - return the number of unique artists
    def self.artists
        Set.new(@@artists).to_a
    end

    # return number of unique genres
    def self.genres
        Set.new(@@genres).to_a
    end

    # class method - return a hash displaying number of albums by each artist    
    def self.album_count
        hash = {}
        @@artists.each do |artist|
            hash[artist] = hash[artist] || 0
            hash[artist] += 1
        end
        hash
    end

    # class method - return a hash displaying number of albums per genre
    def self.genre_count
        hash = {}
        @@genres.each do |genre|
            hash[genre] = hash[genre] || 0
            hash[genre] += 1
        end
        hash
    end
end
