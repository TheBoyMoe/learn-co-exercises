require 'pry'

class Song
    # the Song and Artist classes have a 'belongs to' relationship
    #  - a song 'belongs to' an artist. We enact this relationship by 
    # giving the Song class a getter and setter for Artist
    attr_accessor :title, :artist

    def initialize(title)
        @title = title
    end
end

class Artist
    attr_accessor :name, :genre

    def initialize(name, genre)
        @name = name
        @genre = genre
    end
end

artist = Artist.new('Prince', 'pop')
song = Song.new('Around the World in a Day')
song.artist = artist

binding.pry