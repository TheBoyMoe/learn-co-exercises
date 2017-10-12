require 'pry'

# 'belongs to' relationship - each song instance belongs to an artist
# Represented by adding the artist accessor to Song class, allows us 
# the set/get the artist instance assigned to the song instance

# 'has many' relationship - each artist can have many songs. Represented
# in the Artist class through an array which stores references to all those songs
class Song
    attr_accessor :name, :genre, :artist
    def initialize(name, genre)
        @name = name
        @genre = genre
    end

    def artist_name
        self.artist.name
    end
end

class Artist
    attr_accessor :name
    attr_reader :songs

    def initialize(name)
        @name = name
        @songs = []
    end

    # create the reciprical relationship between artist and song instances    
    # assign the song to the songs collection(creating 'has many' relationship) and
    # associate the song with the particular artist(creating the 'belongs to' relationship)
    def add_song(song)
        self.songs << song
        song.artist = self
        "Added song: #{song.name}, to artist collection"
    end

    def add_song_by_name(name, genre)
        # song = Song.new(name, genre)
        # self.songs <<  song
        # song.artist = self
        self.add_song(Song.new(name, genre))
    end
end

my_way = Song.new('My Way', 'easy listening')
best_is_yet_to_come = Song.new('The Best is Yet to Come', 'easy listening')
fly_me_to_the_moon = Song.new('Fly Me to the Moon', 'easy listening')
frank = Artist.new('Frank Sinatra')
frank.add_song(my_way)
frank.add_song(fly_me_to_the_moon)
frank.add_song(best_is_yet_to_come)
frank.add_song(Song.new('Night and Day', 'easy listening'))
frank.add_song_by_name('I Got the World on a String', 'easy listening')

binding.pry